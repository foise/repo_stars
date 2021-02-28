import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:repo_stars/models/star.dart';

class GraphModel extends ChangeNotifier {
  String _accountName;
  List<String> _repos;
  String _activeRepo;
  List<RepoStar> _repoStars;

  String get accountName => _accountName;
  String get activeRepo => _activeRepo;

  void updateName(String newAccName) {
    _accountName = newAccName;
  }
}
