import 'package:github/github.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:repo_stars/api/github_api.dart';
import 'package:repo_stars/models/github_repos.dart';
import 'package:repo_stars/models/star.dart';
import 'package:repo_stars/service/github_service.dart';

class GraphViewModel extends ChangeNotifier {
  String _accountName;
  GitHubRepos _repos;
  String _activeRepo;

  String get accountName => _accountName;
  String get activeRepo => _activeRepo;
  GitHubRepos get repos => _repos;

  GitHubService _gitHubService;
  GitHubApi _gitHubApi;

  GraphViewModel() {
    _gitHubApi = GitHubApi();
    _gitHubApi.getApi();
    _gitHubService = GitHubService(_gitHubApi);
  }

  Future<void> updateRepos(String newAccName) async {
    _accountName = newAccName;
    _repos = await _gitHubService.getRepos(_accountName);
    _repos.reposList.forEach((Repository repo) => print(repo.name));
    print(_repos.reposList.length);
    notifyListeners();
  }
}
