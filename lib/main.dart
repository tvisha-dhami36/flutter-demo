import 'package:flutter/material.dart';
import 'package:movie_display/movie_screen/MovieHomePage.dart';

import 'connect/connectDB/DatabaseHelper.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieHomePage(),
    );
  }
}
