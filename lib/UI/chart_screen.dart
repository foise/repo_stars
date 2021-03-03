import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/UI/listeners/stars_chart.dart';

class GraphScreen extends StatefulWidget {
  GraphScreen({Key key, this.repoName}) : super(key: key);
  final String repoName;
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repoName),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: StarsChart(),
        ),
      ),
    );
  }
}
