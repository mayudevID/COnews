import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'archive_page.dart';
import 'explore_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _indexButton = 0;

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
            selectedItemColor: Colors.black,
            backgroundColor: const Color(0xFFE3DFDF),
            currentIndex: _indexButton,
            onTap: (int index) {
              setState(() {
                _indexButton = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home_icon.png',
                  width: 27,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/compass_icon.png',
                  width: 27,
                ),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/archive_icon.png',
                  width: 27,
                ),
                label: "Archive",
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (_indexButton) {
        case 0:
          return const HomePage();
        case 1:
          return const ExplorePage();
        case 2:
          return const ArchivePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
