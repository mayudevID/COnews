import 'package:conews/model/all_news_data.dart';
import 'package:conews/model/news_service.dart';
import 'package:conews/ui/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';

class ArchiveList extends StatelessWidget {
  final AllNewsData newsDetails;
  final Box dbnews;
  final int index;
  const ArchiveList(
      {Key? key,
      required this.newsDetails,
      required this.dbnews,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonList() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Share.share("${newsDetails.title}\n\n${newsDetails.link}");
            },
            child: Image.asset('assets/icons/share_icon.png', width: 25),
          ),
          GestureDetector(
            onTap: () {
              dbnews.deleteAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berita dihapus')));
            },
            child: Image.asset('assets/icons/delete_icon.png', width: 25),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsWebView(
              allNews: AllNews(
                title: newsDetails.title,
                link: newsDetails.link,
                image: newsDetails.image,
                isoDate: newsDetails.isoDate,
              ),
              mediaTitle: newsDetails.mediaTitle,
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
                      newsDetails.isoDate,
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
                          newsDetails.title,
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
                  newsDetails.image,
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
