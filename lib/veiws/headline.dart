import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace_app/controller/news_controller.dart';

import 'package:pace_app/veiws/news_page.dart';

import '../database/db1.dart';

class Headline extends StatelessWidget {
  NewsController _newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HEADLINE"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => _newsController.netResult.isTrue
                  ? ListView.builder(
                      itemCount:
                          _newsController.newsList.value!.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(_newsController.newsList.value!.articles.length);
                        var data =
                            _newsController.newsList.value!.articles[index];

                        return tile(index, data);
                      },
                    )
                  : ListView.builder(
                      itemCount: _newsController.articleList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(_newsController.articleList.length);
                        var data = _newsController.articleList[index];

                        return tile(index, data);
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

Widget tile(int index, var data) {
  return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print(data);
          Get.to(() => NewsPage(index: index));
        },
        child: Container(
          height: 250,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Image.network(data.urlToImage!),
              ),
              Center(
                child: Text(
                  data.title!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ));
}
