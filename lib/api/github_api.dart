import 'dart:async';
import 'package:github/github.dart';
import 'package:repo_stars/models/github_repos.dart';

class GitHubApi {
  GitHub github;
  GitHubRepos gitHubRepos;
  List<Repository> reposListFromJson = [];

  void getApi() {
    github = GitHub(
      auth:
          Authentication.withToken("b64bb6890c1e26aeb7b2d94d64858ff14608bb37"),
    );
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
