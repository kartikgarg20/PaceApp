import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pace_app/models/new_api.dart';

class RemoteService {
  static var client = http.Client();

  static Future<List<NewsAPi>?> fetchNews() async {
    var response = await client.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2022-12-24&sortBy=publishedAt&apiKey=87838418498944bbaa25d68f5d6b8715'));
    if (response.statusCode == 200) {
      //
      var jsonString = response.body;
      NewsAPi newsAPi = newsAPiFromJson(response.body);
      return newsAPi.articles;
    } else {
      return null;
    }
  }
}
