import 'dart:ffi';

import 'package:get/state_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pace_app/models/new_api.dart';
import 'package:pace_app/services/api_service.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db1.dart';

class NewsController extends GetxController {
  // ignore: deprecated_member_use
  // List newsList = <NewsAPi>[].obs;
  final isLoading = true.obs;
  final netResult = true.obs;
  var newsList = Rxn<NewsAPi>();
  var articleList = <Article>[].obs;
  @override
  void onInit() {
    checkInterntt();

    super.onInit();
  }

  Future<void> checkInterntt() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      fetchNews1();
      netResult(true);

      print('YAY! Free cute dog pics!');
    } else {
      netResult(false);
      var news1 = await DataBase().getModelList();
      if (news1 != null) {
        articleList.value = news1;
      }
      isLoading(false);

      print('No internet :( Reason:');
    }
  }

  void db() async {
    var handler = DataBase();
    await handler.deleteModel();
    await handler.initializedDB();
  }

  void fetchNews1() async {
    try {
      isLoading(true);
      netResult(true);
      var news = await RemoteService.fetchNews();
      if (news != null) {
        newsList.value = news;
      }
    } finally {
      isLoading(false);

      db();
    }
  }
}
