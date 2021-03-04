import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/UI/listeners/year_selector.dart';
import 'package:repo_stars/bloc/app_model.dart';

class StarsChart extends StatefulWidget {
  @override
  _StarsChartState createState() => _StarsChartState();
}

class _StarsChartState extends State<StarsChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(
      builder: (context, graphModel, child) {
        return graphModel.requestPending
            ? Center(
                child: Container(
                  child: Text("Request Pending"),
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select a year: ",
                        style: TextStyle(fontSize: 18),
                      ),
                      YearSelector(),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: graphModel.chart,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
