import 'dart:async';

import 'package:github/github.dart';
import 'package:path/path.dart';
import 'package:repo_stars/data/models/github_repos.dart';
import 'package:repo_stars/data/models/repo_stars.dart';
import 'package:sqflite/sqflite.dart';

class SaveData {
  Database reposDatabase;
  Map<String, dynamic> valuesHelper;
  String tableName;

  Future<void> openReposDatabase() async {
    openDatabase(
      join(await getDatabasesPath(), 'repo_database.db'),
    ).then((value) => reposDatabase = value);
  }

  Future<void> saveRepoStars(RepoStars repoStars, String accName) async {
    await openReposDatabase().then((value) async {
      //Таблица пересоздается при каждом поиске
      try {
        await deleteStarsTable(repoStars.repo.name, accName);
        await createStarsTable(repoStars, accName);
      } catch (e) {
        await createStarsTable(repoStars, accName);
      }
    });
  }

  Future<void> saveRepos(GitHubRepos gitHubRepos) async {
    await openReposDatabase().then((value) async {
      try {
        tableName = gitHubRepos.accountName;
        tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '_');
        //Таблица пересоздается при каждом поиске
        await reposDatabase.execute('DROP TABLE $tableName');
        await createAccTable(gitHubRepos);
      } catch (e) {
        await createAccTable(gitHubRepos);
      }
    });
  }

  Future<void> createAccTable(GitHubRepos gitHubRepos) async {
    tableName = gitHubRepos.accountName;
    tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '_');
    await reposDatabase.execute(
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, repo_name TEXT, repo_short_name TEXT, language TEXT, star_count INT, pushed_at TEXT, created_at TEXT)');

    for (var item in gitHubRepos.reposList) {
      String language;
      if (item.language != null)
        language = item.language;
      else
        language = '';
      valuesHelper = {
        'repo_name': item.fullName,
        'repo_short_name': item.name,
        'language': language,
        'star_count': item.stargazersCount,
        'pushed_at': item.pushedAt.toIso8601String(),
        'created_at': item.createdAt.toIso8601String(),
      };
      await reposDatabase.insert(gitHubRepos.accountName, valuesHelper,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> createStarsTable(RepoStars repoStars, String accountName) async {
    tableName = accountName + '_' + repoStars.repo.name;
    tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '_');
    await reposDatabase.execute(
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, who_starred TEXT, date_starred TEXT)');
    for (var item in repoStars.repoStarsList) {
      valuesHelper = {
        'who_starred': item.whoStarred,
        'date_starred': item.dateStarred.toIso8601String(),
      };
      await reposDatabase.insert(tableName, valuesHelper,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteStarsTable(String repoName, String accountName) async {
    tableName = accountName + '_' + repoName;
    tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '_');
    await reposDatabase.execute('DROP TABLE $tableName');
  }

  Future<List<RepoStar>> getStarsFromDatabase(
      String repoName, String accName) async {
    tableName = accName + '_' + repoName;
    tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '_');

    await openReposDatabase();
    try {
      final List<Map<String, dynamic>> maps =
          await reposDatabase.query(tableName);
      print(maps);
      return List.generate(maps.length, (i) {
        return RepoStar(
          whoStarred: maps[i]['who_starred'],
          dateStarred: DateTime.parse(maps[i]['date_starred']),
        );
      });
    } catch (e) {
      return [];
    }
  }

  Future<List<Repository>> getReposFromDatabase(String accountName) async {
    await openReposDatabase();
    tableName = accountName;
    tableName = tableName.replaceAll(new RegExp(r'[^\w]+'), '');
    try {
      final List<Map<String, dynamic>> maps =
          await reposDatabase.query(tableName);
      return List.generate(maps.length, (i) {
        return Repository(
          fullName: maps[i]['repo_name'],
          name: maps[i]['repo_short_name'],
          language: maps[i]['language'],
          stargazersCount: maps[i]['star_count'],
          pushedAt: DateTime.parse(maps[i]['pushed_at']),
          createdAt: DateTime.parse(maps[i]['created_at']),
        );
      });
    } catch (e) {
      return [];
    }
  }
}
