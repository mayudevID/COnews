import 'package:conews/model/all_news_data.dart';
import 'package:conews/ui/widgets/archive_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Archive",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 35,
              child: Image.asset(
                'assets/icons/archive_icon.png',
              ),
            )
          ],
        ),
      );
    }

    Widget listArchive() {
      return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: FutureBuilder(
          future: Hive.openBox('db_news'),
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                var dbnews = Hive.box('db_news');
                if (dbnews.length == 0) {
                  return const Center(
                    child: Text(
                      'Arsip Kosong',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                      ),
                    ),
                  );
                } else {
                  return ValueListenableBuilder(
                    valueListenable: dbnews.listenable(),
                    builder: (BuildContext context, value, Widget? child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dbnews.length,
                        itemBuilder: (context, index) {
                          AllNewsData newsDetails = dbnews.getAt(index);
                          return ArchiveList(
                            newsDetails: newsDetails,
                            dbnews: dbnews,
                            index: index,
                          );
                        },
                      );
                    },
                  );
                }
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
          },
        ),
      );
    }

    return ListView(
      children: [
        header(),
        listArchive(),
      ],
    );
  }
}
