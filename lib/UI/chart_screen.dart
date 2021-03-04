import 'package:flutter/material.dart';
import 'package:repo_stars/UI/listeners/stars_chart.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({Key key}) : super(key: key);
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(builder: (context, graphModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${graphModel.accountName}/${graphModel.activeRepoName}'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: Container(
              child: StarsChart(),
            ),
          ),
        ),
      );
    });
  }
}
