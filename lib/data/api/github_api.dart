import 'dart:async';
import 'package:github/github.dart';
import 'package:repo_stars/data/models/github_repos.dart';

class GitHubApi {
  GitHub github;
  GitHubRepos gitHubRepos;
  List<Repository> reposListFromJson = [];

  void getApi() {
    github = GitHub(auth: Authentication.anonymous());
  }

  Future<GitHubRepos> getRepos(String accName) async {
    if (github == null) getApi();
    gitHubRepos = GitHubRepos(accName);
    gitHubRepos.clearRepos();
    reposListFromJson.clear();
    await github.repositories
        .listUserRepositories(accName)
        .forEach((Repository repo) => reposListFromJson.add(repo));
    gitHubRepos.reposList.addAll(reposListFromJson);
    return gitHubRepos;
  }
}
