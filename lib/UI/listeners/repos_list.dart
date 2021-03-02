import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';
import 'package:repo_stars/UI/repo_card.dart';

class ReposList extends StatefulWidget {
  @override
  _ReposListState createState() => _ReposListState();
}

class _ReposListState extends State<ReposList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(
      builder: (context, graphModel, child) {
        if (graphModel.repos != null) {
          return graphModel.repos.reposList.length > 0
              ? ListView.builder(
                  shrinkWrap: false,
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                  itemCount: graphModel.repos.reposList.length,
                  itemBuilder: (context, position) {
                    Repository repo =
                        graphModel.repos.reposList.elementAt(position);
                    return RepoCard(repo: repo);
                  },
                )
              : Container(
                  height: 50,
                  child: Icon(Icons.bus_alert),
                );
        } else {
          return Container(
            height: 50,
            child: Icon(Icons.bus_alert),
          );
        }
      },
    );
  }
}
