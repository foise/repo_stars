import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/UI/listeners/input_field.dart';
import 'package:repo_stars/UI/listeners/repos_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
