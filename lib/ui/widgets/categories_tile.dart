import 'package:flutter/material.dart';

class CategoriesTile extends StatelessWidget {
  final int catIndex;
  final String category;
  final bool isTap;
  const CategoriesTile(
      {Key? key,
      required this.category,
      required this.catIndex,
      required this.isTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      margin: EdgeInsets.only(
        left: (catIndex == 0) ? 30 : 0,
        right: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (isTap) ? Colors.purple : Colors.grey[100],
      ),
      child: Text(
        category,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 13,
          color: (isTap) ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
