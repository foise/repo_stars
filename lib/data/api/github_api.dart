import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github/github.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';

class GitHubApi {
  GitHub github;
  GitHubRepos gitHubRepos;
  RepoStars repoStars;
  http.Client httpClient;
  http.Request request;

  void getApi() {
    github = GitHub(auth: Authentication.anonymous());
    httpClient = new http.Client();
  }

  Future<GitHubRepos> getRepos(String accName) async {
    if (github == null) getApi();
    gitHubRepos = GitHubRepos(accName);
    gitHubRepos.clearRepos();
    await github.repositories
        .listUserRepositories(accName)
        .forEach((repo) => gitHubRepos.reposList.add(repo));
    return gitHubRepos;
  }

  Future<RepoStars> getStars(RepositorySlug slug) async {
    final requestUrl =
        'https://api.github.com/repos/${slug.owner}/${slug.name}/stargazers';

    final response = await httpClient.get(requestUrl,
        headers: {'accept': 'application/vnd.github.v3.star+json'});
    repoStars = RepoStars(slug.name);
    repoStars.fromJSON(jsonDecode(response.body));
    return repoStars;
  }
}
