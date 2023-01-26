import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace_app/controller/news_controller.dart';
import 'package:pace_app/veiws/news_page.dart';

class Headline extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());

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
              () => ListView.builder(
                itemCount: _newsController.newsList.value!.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  print(_newsController.newsList.value!.articles.length);
                  return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          print(
                              _newsController.newsList.value!.articles[index]);
                          Get.to(() => NewsPage(index: index));
                        },
                        child: Container(
                          height: 250,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.network(_newsController.newsList
                                    .value!.articles[index].urlToImage!),
                              ),
                              Center(
                                child: Text(
                                  _newsController
                                      .newsList.value!.articles[index].title!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
