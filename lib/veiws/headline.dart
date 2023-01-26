import 'dart:convert';

import 'package:flutter/foundation.dart';
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
              () => _newsController.isLoading.isTrue
                  ? const Center(
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    )
                  : _newsController.netResult.isTrue
                      ? ListView.builder(
                          itemCount:
                              _newsController.newsList.value!.articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(_newsController
                                .newsList.value!.articles.length);
                            var data =
                                _newsController.newsList.value!.articles[index];
                            var my1;
                            var handler = DataBase();
                            for (var i = 0;
                                i <
                                    _newsController
                                        .newsList.value!.articles.length;
                                i++) {
                              handler.insertArticle(
                                  _newsController.newsList.value!.articles[i]);
                            }
                            bool mybool = true;
                            if (_newsController.netResult.isTrue) {
                              mybool = true;
                            } else {
                              mybool = false;
                            }

                            return tile(
                                index, data, _newsController, my1, mybool);
                          },
                        )
                      : ListView.builder(
                          itemCount: _newsController.articleList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var my1 = my(
                                _newsController.articleList[index].urlToImage!);
                            print(_newsController.articleList.length);
                            var data = _newsController.articleList[index];
                            bool myBool = true;
                            if (_newsController.netResult.isTrue) {
                              myBool = true;
                            } else {
                              myBool = false;
                            }

                            return tile(
                                index, data, _newsController, my1, myBool);
                          },
                        ),
            ),
          )
        ],
      ),
    );
  }
}

Widget tile(int index, var data, var control, var my1, bool myBool1) {
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
                child: myBool1
                    ? Image.network(data.urlToImage!, fit: BoxFit.cover)
                    : Image.memory(my1),
                // : getImageBase64(image: '${data.urlToImage!}')
              ),
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

Uint8List my(String str1) {
  Uint8List decodedbytes = base64.decode(str1);
  return decodedbytes;
}
