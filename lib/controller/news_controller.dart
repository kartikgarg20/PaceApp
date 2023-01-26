import 'package:get/state_manager.dart';
import 'package:pace_app/models/new_api.dart';
import 'package:pace_app/services/api_service.dart';

class NewsController extends GetxController {
  // ignore: deprecated_member_use
  // List newsList = <NewsAPi>[].obs;
  final isLoading = true.obs;
  var newsList = Rxn<NewsAPi>();
  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      var news = await RemoteService.fetchNews();
      if (news != null) {
        newsList.value = news;
      }
    } finally {
      isLoading(false);
    }
  }
}
