import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace_app/controller/news_controller.dart';

class NewsPage extends StatefulWidget {
  final int index;
  NewsPage({Key? key, required this.index}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController _newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.network(_newsController
              .newsList.value!.articles[widget.index].urlToImage!),
          Text("hello"),
        ],
      )),
    );
  }
}
