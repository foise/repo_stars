import 'package:github/github.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:repo_stars/data/api/github_api.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';
import 'package:repo_stars/data/service/github_service.dart';

class GraphViewModel extends ChangeNotifier {
  String _accountName;
  GitHubRepos _repos;
  RepoStars repoStars;
  String _activeRepoName;

  String get accountName => _accountName;
  String get activeRepoName => _activeRepoName;
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

  void setActiveRepo(String repo) {
    _activeRepoName = repo;
  }

  Future<void> getRepoStars(RepositorySlug slug) async {
    setActiveRepo(slug.name);
    repoStars = await _gitHubService.getStars(slug);
  }
}
