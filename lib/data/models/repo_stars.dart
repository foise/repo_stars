import 'package:github/github.dart';

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
  List<int> listOfYears = [];

  RepoStars(this.repo);

  void clearStars() {
    repoStarsList.clear();
  }

  void fromJSON(dynamic jsonMap) {
    if (jsonMap.length != 0) {
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
  }

  List<RepoStar> starsByYearAndMonth(int year, String month) {
    int monthNum;
    List<RepoStar> stars = [];
    switch (month) {
      case "JAN":
        monthNum = 1;
        break;
      case "FEB":
        monthNum = 2;
        break;
      case "MAR":
        monthNum = 3;
        break;
      case "APR":
        monthNum = 4;
        break;
      case "MAY":
        monthNum = 5;
        break;
      case "JUN":
        monthNum = 6;
        break;
      case "JUL":
        monthNum = 7;
        break;
      case "AUG":
        monthNum = 8;
        break;
      case "SEP":
        monthNum = 9;
        break;
      case "OCT":
        monthNum = 10;
        break;
      case "NOV":
        monthNum = 11;
        break;
      case "DEC":
        monthNum = 12;
        break;

      default:
    }

    for (var item in repoStarsList) {
      if (item.dateStarred.year == year && item.dateStarred.month == monthNum) {
        stars.add(item);
      }
    }
    return stars;
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

    if (starsPerMonth[year] == null) starsPerMonth[year] = {};
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
