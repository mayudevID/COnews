import 'package:conews/ui/widgets/category_card.dart';
import 'package:conews/ui/widgets/media_category_list.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 34),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Explore",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 35,
              child: Image.asset(
                'assets/icons/compass_icon.png',
              ),
            )
          ],
        ),
      );
    }

    Widget mediaTitle(String title) {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget gridCategories(String mediaTitle) {
      return Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 19, 30, 34),
          child: GridView.count(
            childAspectRatio: 1.3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(
              (mapMediaCategory[mediaTitle]).length,
              (categoryIndex) {
                return Center(
                  child: CategoryCard(categoryIndex, mediaTitle),
                );
              },
            ),
          ),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        mediaTitle("CNN News"),
        gridCategories(mapMediaCategory.entries.toList()[0].key),
        mediaTitle("CNBC News"),
        gridCategories(mapMediaCategory.entries.toList()[1].key),
      ],
    );
  }
}
