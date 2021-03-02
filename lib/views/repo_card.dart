import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:repo_stars/utils/github_colors.dart';
import 'package:intl/intl.dart';

class RepoCard extends StatelessWidget {
  final Repository repo;
  final GitHubColors colors = GitHubColors();

  RepoCard({Key key, @required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: InkWell(
        splashColor: Colors.deepPurple.withAlpha(50),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          padding: EdgeInsets.only(top: 8, left: 12),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${repo.owner.login}/${repo.name}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Color(colors.getColor(repo.language)),
                        size: 13,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text(
                        '${repo.language}',
                        style: TextStyle(fontSize: 13.5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.black,
                        size: 15,
                      ),
                      Text(
                        '${repo.stargazersCount}',
                        style: TextStyle(fontSize: 13.5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Updated ${DateFormat.yMMMMd().format(repo.updatedAt)}',
                        style: TextStyle(fontSize: 13.5),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
