import 'dart:convert';
import 'package:conews/ui/widgets/media_category_list.dart';
import 'package:http/http.dart' as http;

class AllNews {
  // MODEL
  String title;
  String link;
  String isoDate;
  String image;

  AllNews({
    required this.title,
    required this.link,
    required this.isoDate,
    required this.image,
  });

  factory AllNews.fromJson(Map<String, dynamic> obj) {
    return AllNews(
      title: obj['title'],
      link: obj['link'],
      isoDate: obj['isoDate'],
      image: obj['image']['small'],
    );
  }

  // SERVICE
  static Future<List<AllNews>> getDataCnnNews() async {
    String mediaTitle = mapMediaCategory.entries.toList()[0].key;
    var getUrl = 'https://berita-indo-api.vercel.app/v1/$mediaTitle/';

    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List data = (jsonObj as Map<String, dynamic>)['data'];

      List<AllNews> listDataCnnNews = [];
      for (var singleData in data) {
        listDataCnnNews.add(AllNews.fromJson(singleData));
      }

      return listDataCnnNews;
    } else {
      throw Exception("Gagal mendapatkan data");
    }
  }

  static Future<List<AllNews>> getDataCnbcNews() async {
    String mediaTitle = mapMediaCategory.entries.toList()[1].key;
    var getUrl = 'https://berita-indo-api.vercel.app/v1/$mediaTitle/';

    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List data = (jsonObj as Map<String, dynamic>)['data'];

      List<AllNews> listDataCnbcNews = [];
      for (var singleData in data) {
        listDataCnbcNews.add(AllNews.fromJson(singleData));
      }

      return listDataCnbcNews;
    } else {
      throw Exception("Gagal mendapatkan data");
    }
  }

  static Future<List<AllNews>> getDataNewsCategory(
      String media, String category) async {
    var getUrl = 'https://berita-indo-api.vercel.app/v1/$media/$category';

    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List data = (jsonObj as Map<String, dynamic>)['data'];

      List<AllNews> listDataNewsCategory = [];
      for (var singleData in data) {
        listDataNewsCategory.add(AllNews.fromJson(singleData));
      }

      return listDataNewsCategory;
    } else {
      throw Exception("Gagal mendapatkan data");
    }
  }
}
