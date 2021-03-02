import 'package:repo_stars/api/github_api.dart';
import 'package:repo_stars/models/github_repos.dart';

class GitHubService {
  final GitHubApi gitHubApi;
  GitHubService(this.gitHubApi);

  Future<GitHubRepos> getRepos(String accName) async {
    return await gitHubApi.getRepos(accName);
  }
}
