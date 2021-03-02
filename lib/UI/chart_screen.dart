import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphView extends StatefulWidget {
  GraphView({Key key, this.repoName}) : super(key: key);
  final String repoName;
  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repoName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
