class RepoStar {
  String whoStarred;
  DateTime dateStarred;

  RepoStar({
    this.whoStarred,
    this.dateStarred,
  });

  RepoStar fromJSON(dynamic json) {
    return RepoStar(
      whoStarred: "foise",
      dateStarred: DateTime(DateTime.april),
    );
  }
}
