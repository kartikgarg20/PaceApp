import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pace_app/models/new_api.dart';

class RemoteService {
  static var client = http.Client();

  static Future<NewsAPi?> fetchNews() async {
    print('hello');
    var response = await client.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2022-12-25&sortBy=publishedAt&apiKey=8ccbd347bc5a46d9b077667e4ed48358'));
    var jsonString = response.body;
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      //   for (Map<String, dynamic> i in data) {
      //   newsList.add(NewsAPi.fromJson(i));
      //   print(i);
      // }

      print('hello');
      // NewsAPi api = NewsAPi.fromJson(jsonDecode(jsonString));

      return newsAPiFromJson(jsonString);
    } else {
      return null;
    }
  }
}
