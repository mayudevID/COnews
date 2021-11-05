import 'package:conews/model/all_news_data.dart';
import 'package:conews/model/news_service.dart';
import 'package:conews/ui/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';

class NewsList extends StatelessWidget {
  final AllNews allNews;
  final int mediaIndex;
  final String mediaTitle;
  const NewsList(
      {Key? key,
      required this.allNews,
      required this.mediaIndex,
      required this.mediaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonList() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Share.share("${allNews.title}\n\n${allNews.link}");
            },
            child: Image.asset('assets/icons/share_icon.png', width: 25),
          ),
          GestureDetector(
            onTap: () async {
              var box = await Hive.openBox('db_news');
              var data = AllNewsData(
                allNews.title,
                allNews.link,
                allNews.isoDate,
                allNews.image,
                mediaTitle,
              );
              await box.add(data);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berita diarsipkan')));
            },
            child: Image.asset(
              'assets/icons/archive_icon.png',
              width: 25,
            ),
          ),
        ],
      );
    }

    switch (mediaIndex) {
      case 0:
        {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsWebView(
                    allNews: allNews,
                    mediaTitle: mediaTitle,
                  ),
                ),
              );
            },
            child: Center(
              child: Container(
                width: 351,
                height: 180,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ShaderMask(
                        shaderCallback: (rectangle) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
                          ).createShader(
                            rectangle,
                          );
                        },
                        blendMode: BlendMode.darken,
                        child: Image.network(
                          allNews.image,
                          width: 351,
                          height: 180,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(13, 0, 13, 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            allNews.isoDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            allNews.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      default:
        {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsWebView(
                    allNews: allNews,
                    mediaTitle: mediaTitle,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              //width: 351,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(7, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            allNews.isoDate,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFF717171),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                allNews.title,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          buttonList(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        allNews.image,
                        width: 110,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    }
  }
}
