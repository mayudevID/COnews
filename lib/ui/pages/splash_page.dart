import 'package:conews/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<AllNewsProvider>(context, listen: false).getCnnNewsList();
    await Provider.of<AllNewsProvider>(context, listen: false)
        .getCnbcNewsList();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: const CircularProgressIndicator(color: Colors.black),
        ),
      ),
    );
  }
}
