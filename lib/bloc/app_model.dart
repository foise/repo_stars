import 'package:github/github.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:repo_stars/data/api/github_api.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';
import 'package:repo_stars/data/service/github_service.dart';

class GraphViewModel extends ChangeNotifier {
  bool requestError;
  bool requestPending;

  String _accountName;
  GitHubRepos _repos;
  RepoStars _repoStars;
  String _activeRepoName;

  String get accountName => _accountName;
  String get activeRepoName => _activeRepoName;
  GitHubRepos get repos => _repos;
  RepoStars get repoStars => _repoStars;

  GitHubService _gitHubService;
  GitHubApi _gitHubApi;

  GraphViewModel() {
    _gitHubApi = GitHubApi();
    _gitHubApi.getApi();
    _gitHubService = GitHubService(_gitHubApi);
  }

  Future<void> updateRepos(String newAccName) async {
    _accountName = newAccName;
    requestError = false;
    requestPending = true;
    await _gitHubService.getRepos(_accountName).then((value) {
      requestPending = false;
      _repos = value;
      _repos.reposList.forEach((Repository repo) => print(repo.name));
      print(_repos.reposList.length);
      notifyListeners();
    }).catchError((onError) => handleError());
  }

  void setActiveRepo(String repo) {
    _activeRepoName = repo;
  }

  Future<void> getRepoStars(RepositorySlug slug) async {
    setActiveRepo(slug.name);
    requestError = false;
    requestPending = true;
    await _gitHubService.getStars(slug).then((value) {
      requestPending = false;
      _repoStars = value;
      //check years since github launch
      for (var j = 2008; j < DateTime.now().year + 1; j++) {
        for (var i = 1; i < 13; i++) {
          _repoStars.mapStars(j, i);
        }
      }
      notifyListeners();
    }).catchError((onError) => handleError());
  }

  void handleError() {
    requestPending = false;
    requestError = true;
    notifyListeners();
  }
}
