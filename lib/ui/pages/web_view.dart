import 'package:conews/model/all_news_data.dart';
import 'package:conews/model/news_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatelessWidget {
  final AllNews allNews;
  final String mediaTitle;
  const NewsWebView({Key? key, required this.allNews, required this.mediaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBarNews() {
      return AppBar(
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mediaTitle,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
            Text(
              allNews.title,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      );
    }

    Widget webViewNews() {
      return WebView(
        initialUrl: allNews.link,
        javascriptMode: JavascriptMode.unrestricted,
      );
    }

    Widget speedDialOption() {
      return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Image.asset(
              'assets/icons/share_icon.png',
              width: 30,
            ),
            backgroundColor: Colors.white,
            onTap: () {
              Share.share("${allNews.title}\n\n${allNews.link}");
            },
            label: 'Share',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: "Poppins",
            ),
            labelBackgroundColor: Colors.white,
          ),
          SpeedDialChild(
            child: Image.asset(
              'assets/icons/archive_icon.png',
              width: 30,
            ),
            backgroundColor: Colors.white,
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
            label: 'Archive',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: "Poppins",
            ),
            labelBackgroundColor: Colors.white,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appBarNews(),
      body: webViewNews(),
      floatingActionButton: speedDialOption(),
    );
  }
}
