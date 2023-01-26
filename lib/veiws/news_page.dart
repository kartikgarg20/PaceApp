import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace_app/controller/news_controller.dart';

class NewsPage extends StatefulWidget {
  final int index;
  var data;
  NewsPage({Key? key, required this.index, required this.data})
      : super(key: key);

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
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              _newsController
                  .newsList.value!.articles[widget.index].urlToImage!,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
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
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: new BoxDecoration(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Icon(
                            Icons.arrow_back_sharp,
                            size: 25,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.data.title,
                    style: TextStyle(
                        color: Color(0xFFfbfbfb),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data.source.name!,
                        style: TextStyle(
                            color: Color(0xFFbababa),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.data.publishedAt!.toString().substring(0, 10),
                        style: TextStyle(
                            color: Color(0xFFbababa),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.data.description!,
                    style: TextStyle(
                        color: Color(0xFFbababa),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height,
          ),
        ],
      )),
    );
  }
}
