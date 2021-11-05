import 'package:conews/ui/pages/explore_category.dart';
import 'package:flutter/material.dart';
import 'media_category_list.dart';

class CategoryCard extends StatelessWidget {
  final int categoryIndex;
  final String mediaTitle;

  const CategoryCard(this.categoryIndex, this.mediaTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = (mapMediaCategory[mediaTitle])[categoryIndex];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExploreCategory(
                category: category,
                mediaTitle: mediaTitle,
              ),
            ));
      },
      child: SizedBox(
        width: 100,
        height: 75,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/$mediaTitle/${mediaTitle}_$categoryIndex.png',
              width: 100,
              height: 75,
              fit: BoxFit.fitWidth,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                category,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
