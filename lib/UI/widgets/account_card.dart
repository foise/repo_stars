import 'package:flutter/material.dart';
import 'package:repo_stars/data/models/repo_stars.dart';
import 'package:repo_stars/data/utils/github_colors.dart';
import 'package:intl/intl.dart';

class AccountCard extends StatelessWidget {
  final RepoStar star;
  final String repoName;
  final GitHubColors colors = GitHubColors();

  AccountCard({Key key, @required this.star, this.repoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 12),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                '${star.whoStarred} starred $repoName on ${DateFormat.yMMMd().format(star.dateStarred)}'),
          ],
        ),
      ),
    );
  }
}
