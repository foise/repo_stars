import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/UI/widgets/account_card.dart';
import 'package:repo_stars/bloc/app_model.dart';
import 'package:repo_stars/data/models/repo_stars.dart';

class StarredList extends StatefulWidget {
  @override
  _StarredListState createState() => _StarredListState();
}

class _StarredListState extends State<StarredList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(builder: (context, graphModel, child) {
      dynamic list = graphModel.repoStars.starsByYearAndMonth(
          graphModel.selectedYear, graphModel.selectedMonth);

      return list.length > 0
          ? ListView.builder(
              shrinkWrap: false,
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
              itemCount: list.length,
              itemBuilder: (context, position) {
                RepoStar star = list.elementAt(position);
                return AccountCard(
                  star: star,
                  repoName: 'repo',
                );
              },
            )
          : Center(
              child: Text(
                "No stars :(",
                style: TextStyle(fontSize: 25),
              ),
            );
    });
  }
}
