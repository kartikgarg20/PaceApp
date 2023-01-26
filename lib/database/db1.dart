import 'dart:math';

import 'package:pace_app/models/new_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(
      join(path, 'newsarticle2.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
  CREATE TABLE IF NOT EXISTS article (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
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

    result = await db.insert('article', article.toMap(),
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
      return Article(
          source: maps[i]['source'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          url: maps[i]['url'],
          publishedAt: maps[i]['publishedAt'],
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
