import 'package:conews/model/news_service.dart';
import 'package:conews/ui/widgets/categories_tile.dart';
import 'package:conews/ui/widgets/media_category_list.dart';
import 'package:conews/ui/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExploreCategory extends StatelessWidget {
  final String category;
  final String mediaTitle;
  const ExploreCategory(
      {Key? key, required this.category, required this.mediaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List categoryList = (mapMediaCategory[mediaTitle]);
    Widget categories() {
      return Container(
        height: 40,
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, index) {
            bool isTap = false;
            if (category == categoryList[index]) {
              isTap = !isTap;
            }
            return CategoriesTile(
                category: categoryList[index], catIndex: index, isTap: isTap);
          },
        ),
      );
    }

    Widget newsListContent() {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: FutureBuilder(
            future: AllNews.getDataNewsCategory(mediaTitle, category),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AllNews> data = snapshot.data as List<AllNews>;
                return ListView.builder(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsList(
                      allNews: data[index],
                      mediaIndex: index,
                      mediaTitle: mediaTitle,
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mediaTitle,
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              category,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          categories(),
          newsListContent(),
        ],
      ),
    );
  }
}
