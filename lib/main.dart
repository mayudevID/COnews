import 'package:conews/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'model/all_news_data.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'ui/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(AllNewsDataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllNewsProvider()),
      ],
      child: const MaterialApp(
        title: "COnews",
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
