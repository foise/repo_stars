import 'dart:convert';

import 'package:github/github.dart';
import 'package:intl/intl.dart';

class RepoStar {
  String whoStarred;
  DateTime dateStarred;

  RepoStar({
    this.whoStarred,
    this.dateStarred,
  });
}

class RepoStars {
  Repository repo;
  List<RepoStar> repoStarsList = [];
  Map<int, Map<String, int>> starsPerMonth = {};

  RepoStars(this.repo);

  void clearStars() {
    repoStarsList.clear();
  }

  void fromJSON(dynamic jsonMap) {
    for (var i = 0; i < jsonMap.length; i++) {
      if (jsonMap[i] != null) {
        RepoStar repoStar = RepoStar();
        var date = DateTime.parse(jsonMap[i]['starred_at']);
        repoStar.whoStarred = jsonMap[i]['user']['login'];
        repoStar.dateStarred = date;
        repoStarsList.add(repoStar);
      } else {
        break;
      }
    }
  }

  void mapStars(int year, int month) {
    String monthName;
    switch (month) {
      case 1:
        monthName = "JAN";
        break;
      case 2:
        monthName = "FEB";
        break;
      case 3:
        monthName = "MAR";
        break;
      case 4:
        monthName = "APR";
        break;
      case 5:
        monthName = "MAY";
        break;
      case 6:
        monthName = "JUN";
        break;
      case 7:
        monthName = "JUL";
        break;
      case 8:
        monthName = "AUG";
        break;
      case 9:
        monthName = "SEP";
        break;
      case 10:
        monthName = "OCT";
        break;
      case 11:
        monthName = "NOV";
        break;
      case 12:
        monthName = "DEC";
        break;

      default:
    }

    starsPerMonth[year] = {};
    starsPerMonth[year].addAll({monthName: 0});
    for (var star in repoStarsList) {
      if (star.dateStarred.month == month && star.dateStarred.year == year) {
        starsPerMonth[year][monthName]++;
        // print(
        //     "$year $monthName stars count: ${starsPerMonth[year][monthName]}");
      }
    }
  }
}
