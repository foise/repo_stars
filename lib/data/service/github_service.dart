import 'package:github/github.dart';
import 'package:repo_stars/data/api/github_api.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';

class GitHubService {
  final GitHubApi gitHubApi;
  GitHubService(this.gitHubApi);

  Future<GitHubRepos> getRepos(String accName) async {
    return await gitHubApi.getRepos(accName);
  }

  Future<RepoStars> getStars(RepositorySlug slug) async {
    return await gitHubApi.getStars(slug);
  }
}
