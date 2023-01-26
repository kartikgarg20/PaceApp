import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace_app/controller/news_controller.dart';

import 'package:pace_app/veiws/news_page.dart';
import 'package:path/path.dart';

import '../database/db1.dart';

class Headline extends StatelessWidget {
  NewsController _newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("HEADLINE"),
      ),
      backgroundColor: Color(0xFF464646),
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: InkWell(
        onTap: () {
          print(data);
          Get.to(() => NewsPage(index: index, data: data));
        },
        child: Stack(
          children: [
            Container(
              height: 225,
              width: 400,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(data.urlToImage!, fit: BoxFit.cover)),
            ),
            Container(
              height: 225,
              width: 400,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,

                        Color.fromARGB(255, 0, 0, 0)
                        //add more colors for gradient
                      ],
                      begin: Alignment.topCenter, //begin of the gradient color
                      end: Alignment.bottomCenter, //end of the gradient color
                      stops: [0, 1] //stops for individual color
                      //set the stops number equal to numbers of color
                      ),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        data.title,
                        style: TextStyle(
                            color: Color(0xFFfbfbfb),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.source.name!,
                            style: TextStyle(
                                color: Color(0xFFbababa),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.publishedAt!.toString().substring(0, 10),
                            style: TextStyle(
                                color: Color(0xFFbababa),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                height: 225,
                width: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20))),
          ],
        ),
      ));
}
