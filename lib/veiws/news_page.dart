import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pace_app/controller/news_controller.dart';
import 'package:pace_app/models/new_api.dart';

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
          Text("hello"),
        ],
      )),
    );
  }
}
