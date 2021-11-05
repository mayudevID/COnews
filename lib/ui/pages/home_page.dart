import 'package:conews/model/news_service.dart';
import 'package:conews/provider/news_provider.dart';
import 'package:conews/ui/widgets/media_category_list.dart';
import 'package:conews/ui/widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AllNewsProvider allNewsProvider = Provider.of<AllNewsProvider>(context);

    Widget newsListContent(List<AllNews> allNews, String mediaTitle) {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ListView.builder(
          shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: allNews.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsList(
              allNews: allNews[index],
              mediaIndex: index,
              mediaTitle: mediaTitle,
            );
          },
        ),
      );
    }

    Widget bodyContent() {
      return TabBarView(
        children: [
          RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              await allNewsProvider.getCnnNewsList();
              setState(() {});
            },
            child: newsListContent(
              allNewsProvider.cnnNews,
              mapMediaCategory.entries.toList()[0].key,
            ),
          ),
          RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              await allNewsProvider.getCnbcNewsList();
              setState(() {});
            },
            child: newsListContent(
              allNewsProvider.cnbcNews,
              mapMediaCategory.entries.toList()[1].key,
            ),
          ),
        ],
      );
    }

    PreferredSizeWidget appBarContent() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Berita Terkini",
          style: TextStyle(color: Colors.black, fontFamily: "Poppins"),
        ),
        bottom: const TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: [
            Tab(text: "CNN News"),
            Tab(text: "CNBC News"),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AllNewsProvider()),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBarContent(),
          body: bodyContent(),
        ),
      ),
    );
  }
}
