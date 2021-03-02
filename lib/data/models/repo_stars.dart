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
  String repoName;
  List<RepoStar> repoStarsList = [];

  RepoStars(this.repoName);

  void clearStars() {
    repoStarsList.clear();
  }

  void fromJSON(dynamic jsonMap) {
    for (var i = 0; i < jsonMap.length; i++) {
      RepoStar repoStar = RepoStar();
      var date = DateTime.parse(jsonMap[i]['starred_at']);
      repoStar.whoStarred = jsonMap[i]['user']['login'];
      repoStar.dateStarred = date;

      repoStarsList.add(repoStar);

      print(
          "${repoStar.whoStarred} starred $repoName on ${DateFormat.yMMMMd().format(date)}");
    }
  }
}