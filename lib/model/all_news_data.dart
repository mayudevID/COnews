import 'package:hive/hive.dart';
part 'all_news_data.g.dart';

@HiveType(typeId: 0)
class AllNewsData {
  @HiveField(0)
  String title;
  @HiveField(1)
  String link;
  @HiveField(2)
  String isoDate;
  @HiveField(3)
  String image;
  @HiveField(4)
  String mediaTitle;

  AllNewsData(this.title, this.link, this.isoDate, this.image, this.mediaTitle);
}
