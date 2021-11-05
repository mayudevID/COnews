import 'package:conews/model/news_service.dart';
import 'package:flutter/material.dart';

class AllNewsProvider with ChangeNotifier {
  List<AllNews> _allCnnNews = [];
  List<AllNews> _allCnbcNews = [];

  List<AllNews> get cnnNews => _allCnnNews;
  List<AllNews> get cnbcNews => _allCnbcNews;

  set cnnNews(List<AllNews> news) {
    _allCnnNews = news;
    notifyListeners();
  }

  set cnbcNews(List<AllNews> news) {
    _allCnbcNews = news;
    notifyListeners();
  }

  Future<void> getCnnNewsList() async {
    try {
      List<AllNews> news = await AllNews.getDataCnnNews();
      _allCnnNews = news;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> getCnbcNewsList() async {
    try {
      List<AllNews> news = await AllNews.getDataCnbcNews();
      _allCnbcNews = news;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
