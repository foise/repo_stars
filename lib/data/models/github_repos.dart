import 'package:github/github.dart';

class GitHubRepos {
  String accountName;
  List<Repository> reposList = [];

  GitHubRepos(this.accountName);

  void clearRepos() {
    reposList.clear();
  }
}
