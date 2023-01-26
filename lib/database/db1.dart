import 'dart:convert';
import 'dart:math';

import 'package:pace_app/models/new_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'newsarticle5.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
  CREATE TABLE IF NOT EXISTS article (
        source TEXT,
        author TEXT NULL,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      );""");
      },
    );
  }
//   Future<Article> add(Article article) async {
//    var dbClient = await db;
//    article.id = await dbClient.insert('article', article.toMap());
//    return article;
//  }

  // insert data
  Future<int> insertArticle(Article article) async {
    int result = 0;
    final Database db = await initializedDB();
    var new2 = await article.toMap();

    result = await db.insert('article', new2,
        conflictAlgorithm: ConflictAlgorithm.replace);

    print('instering data ');

    return result;
  }

  // Future<List<Article>> fetchContacts() async {
  //   final Database db = await initializedDB();
  //   List<Map> contacts = await db.query(Contact.tblContact);
  //   return contacts.length == 0
  //       ? []
  //       : contacts.map((x) => Contact.fromMap(x)).toList();
  // }

  Future<List<Article>> getModelList() async {
    final Database db = await initializedDB();
    final List<Map<String, dynamic>> maps = await db.query('article');

    return List.generate(maps.length, (i) {
      // String x = maps[i]['source']['name'] as String;
      // print(x);
      var data = maps[i]['source'];

      var dataSp = data.split(',');

      Map<String, String> mapData = Map();

      dataSp.forEach(
          (element) => mapData[element.split('=')[0]] = element.split('=')[1]);
      print(mapData.runtimeType);

      return Article(
          source: Source(id: null, name: mapData.values.elementAt(0)),
          title: maps[i]['title'],
          description: maps[i]['description'],
          url: maps[i]['url'],
          urlToImage: maps[i]['urlToImage'],
          publishedAt: DateTime.parse(maps[i]['publishedAt']),
          content: maps[i]['content']);
    });
  }

  Future<void> deleteModel() async {
    final Database db = await initializedDB();
    await db.delete('article');
  }

  // retrieve data
  Future<List<Article>> retrieveArticles() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('article');
    print('Uploading data ');
    return queryResult.map((e) => Article.fromJson(e)).toList();
  }

  // delete user
  // Future<void> deleteArticles(int id) async {
  //   final db = await initializedDB();
  //   await db.delete(
  //     'article',
  //     // where: "id = ?",
  //     // whereArgs: [id],
  //   );
  //   print('Deleteing data ');
  // }
}
