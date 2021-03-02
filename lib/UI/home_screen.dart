import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/UI/listeners/input_field.dart';
import 'package:repo_stars/UI/listeners/repos_list.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputField(),
          Expanded(
            child: ReposList(),
          ),
        ],
      ),
    );
  }
}
