import 'package:flutter/material.dart';
import 'package:repo_stars/UI/listeners/starred_list.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';

class StarsScreen extends StatefulWidget {
  @override
  _StarsScreenState createState() => _StarsScreenState();
}

class _StarsScreenState extends State<StarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(builder: (context, graphModel, child) {
      dynamic list = graphModel.repoStars.starsByYearAndMonth(
          graphModel.selectedYear, graphModel.selectedMonth);
      return Scaffold(
        appBar: AppBar(
          title: Text('${graphModel.accountName}/${graphModel.activeRepoName}'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '${graphModel.selectedMonth} ${graphModel.selectedYear}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Stars amount: ${list.length}',
              style: TextStyle(fontSize: 15),
            ),
            Expanded(
              child: StarredList(),
            )
          ],
        ),
      );
    });
  }
}
