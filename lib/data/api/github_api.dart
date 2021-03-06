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
    if (github == null) getApi();
    await github.repositories.getRepository(slug).then((value) async {
      repoStars = new RepoStars(value);
    });

    PaginationHelper helper = PaginationHelper(github);
    await helper.fetchStreamed(
      'GET',
      'https://api.github.com/repos/${slug.owner}/${slug.name}/stargazers',
      headers: {
        'accept': 'application/vnd.github.v3.star+json',
      },
    ).forEach((element) {
      repoStars.fromJSON(jsonDecode(element.body));
    });

    return repoStars;
  }
}
