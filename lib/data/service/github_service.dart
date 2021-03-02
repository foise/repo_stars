import 'package:repo_stars/data/api/github_api.dart';
import 'package:repo_stars/data/models/github_repos.dart';

class GitHubService {
  final GitHubApi gitHubApi;
  GitHubService(this.gitHubApi);

  Future<GitHubRepos> getRepos(String accName) async {
    return await gitHubApi.getRepos(accName);
  }
}
