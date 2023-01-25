import 'package:get/state_manager.dart';
import 'package:pace_app/models/new_api.dart';
import 'package:pace_app/services/api_service.dart';

class NewsController extends GetxController {
  // ignore: deprecated_member_use
  // List newsList = <NewsAPi>[].obs;
  var newsList = <NewsAPi>[].obs;
  @override
  void onInit() {
    fetchNews();
    // TODO: implement onInit
    super.onInit();
  }

  void fetchNews() async {
    var news = await RemoteService.fetchNews();
    if (news != null) {
      newsList.value = news;
    }
  }
}
