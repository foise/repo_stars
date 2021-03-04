import 'package:github/github.dart';
import 'package:flutter/material.dart';
import 'package:repo_stars/data/api/github_api.dart';
import 'package:repo_stars/data/models/chart.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';
import 'package:repo_stars/data/service/github_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:repo_stars/main.dart';

class GraphViewModel extends ChangeNotifier {
  bool requestError;
  bool requestPending;

  String _accountName;
  GitHubRepos _repos;
  RepoStars _repoStars;
  String _activeRepoName;

  int _selectedYear;
  List<DropdownMenuItem<int>> yearSelector = [];
  charts.BarChart _chart;
  String _selectedMonth;

  String get accountName => _accountName;
  String get activeRepoName => _activeRepoName;
  GitHubRepos get repos => _repos;
  RepoStars get repoStars => _repoStars;
  int get selectedYear => _selectedYear;
  charts.BarChart get chart => _chart;
  String get selectedMonth => _selectedMonth;

  GitHubService _gitHubService;
  GitHubApi _gitHubApi;

  GraphViewModel() {
    _gitHubApi = GitHubApi();
    _gitHubApi.getApi();
    _gitHubService = GitHubService(_gitHubApi);
    requestError = true;
    requestPending = false;
    _selectedYear = null;
  }

  Future<void> updateRepos(String newAccName) async {
    _accountName = newAccName;
    setRequestError(false);
    setRequestPending(true);
    await _gitHubService.getRepos(_accountName).then((value) {
      setRequestPending(false);
      _repos = value;
      _repos.reposList.forEach((Repository repo) => print(repo.name));
      print(_repos.reposList.length);
      notifyListeners();
    }).catchError((onError) => handleError(onError));
  }

  void setActiveRepo(String repo) {
    _activeRepoName = repo;
  }

  Future<void> getRepoStars(RepositorySlug slug) async {
    if (requestPending) return;
    setActiveRepo(slug.name);
    setRequestError(false);
    setRequestPending(true);
    _repoStars = null;
    _chart = null;
    await _gitHubService.getStars(slug).then((value) {
      setRequestPending(false);
      _repoStars = value;

      _repoStars.listOfYears.clear();

      //check years since repo creation
      for (var j = _repoStars.repo.createdAt.year;
          j < DateTime.now().year + 1;
          j++) {
        _repoStars.listOfYears.add(j);
        for (var i = 1; i < 13; i++) {
          _repoStars.mapStars(j, i);
        }
      }
      buildYearSelector();
      notifyListeners();
    }).catchError((onError) => handleError(onError));
  }

  void buildYearSelector() {
    yearSelector = [];
    if (_repoStars.repoStarsList.length != 0) {
      _selectedYear = null;
      yearSelector.clear();
      yearSelector =
          _repoStars.listOfYears.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList();
      notifyListeners();
    } else {
      yearSelector = null;
      notifyListeners();
    }
  }

  void buildChart() {
    final data = [
      new Stars('JAN', 1, _repoStars.starsPerMonth[_selectedYear]['JAN']),
      new Stars('FEB', 2, _repoStars.starsPerMonth[_selectedYear]['FEB']),
      new Stars('MAR', 3, _repoStars.starsPerMonth[_selectedYear]['MAR']),
      new Stars('APR', 4, _repoStars.starsPerMonth[_selectedYear]['APR']),
      new Stars('MAY', 5, _repoStars.starsPerMonth[_selectedYear]['MAY']),
      new Stars('JUN', 6, _repoStars.starsPerMonth[_selectedYear]['JUN']),
      new Stars('JUL', 7, _repoStars.starsPerMonth[_selectedYear]['JUL']),
      new Stars('AUG', 8, _repoStars.starsPerMonth[_selectedYear]['AUG']),
      new Stars('SEP', 9, _repoStars.starsPerMonth[_selectedYear]['SEP']),
      new Stars('OCT', 10, _repoStars.starsPerMonth[_selectedYear]['OCT']),
      new Stars('NOV', 11, _repoStars.starsPerMonth[_selectedYear]['NOV']),
      new Stars('DEC', 12, _repoStars.starsPerMonth[_selectedYear]['DEC']),
    ];

    var series = [
      new charts.Series<Stars, String>(
        id: 'Stars',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (Stars stars, _) => stars.month,
        measureFn: (Stars stars, _) => stars.count,
        data: data,
      ),
    ];

    _chart = new charts.BarChart(
      series,
      behaviors: [
        new charts.ChartTitle('Stars per Month',
            behaviorPosition: charts.BehaviorPosition.top,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 18),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Tap on any bar to show details',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 14),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: (model) {
            setSelectedMonth(model.selectedDatum.first.datum.month);
            navigatorKey.currentState.pushNamed('/stars_screen');
            buildChart();
          },
          updatedListener: (model) {},
        )
      ],
    );
    notifyListeners();
  }

  void setRequestPending(bool value) {
    requestPending = value;
    notifyListeners();
  }

  void setRequestError(bool value) {
    requestError = value;
    notifyListeners();
  }

  void setSelectedYear(int year) {
    _selectedYear = year;
    buildChart();
    notifyListeners();
  }

  void setSelectedMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void handleError(dynamic error) {
    requestPending = false;
    requestError = true;
    notifyListeners();
  }
}
