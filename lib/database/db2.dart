// import 'dart:async';
// import 'package:pace_app/models/new_api.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DbManager {
//   late Database _database;

//   Future openDb() async {
//     _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
//         version: 1, onCreate: (Database db, int version) async {
//       await db.execute(
//         """
//   CREATE TABLE IF NOT EXISTS article (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//         source TEXT,
//         author TEXT
//         title TEXT,
//         description TEXT,
//         url TEXT,
//         urlToImage TEXT,
//         publishedAt TEXT,
//         content TEXT
//       );""",
//       );
//     });
//     return _database;
//   }

//   Future insertModel(Article article) async {
//     await openDb();
//     return await _database.insert('model', article.toJson());
//   }

//   Future<List<Article>> getModelList() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database.query('model');

//     return List.generate(maps.length, (i) {
//       return Article(
//           source: maps[i]['source'],
//           title: maps[i]['title'],
//           description: maps[i]['description'],
//           url: maps[i]['url'],
//           publishedAt: maps[i]['publishedAt'],
//           content: maps[i]['content']);
//     });
//     // return maps
//     //     .map((e) => Model(
//     //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
//     //     .toList();
//   }

//   Future<int> updateModel(Article model) async {
//     await openDb();
//     return await _database.update('model', model.toJson(),
//         where: "id = ?", whereArgs: [model.id]);
//   }

//   Future<void> deleteModel(Article model) async {
//     await openDb();
//     await _database.delete('model', where: "id = ?", whereArgs: [model.id]);
//   }
// }
