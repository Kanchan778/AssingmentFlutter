import 'package:assignment/loadingscreen.dart';// imported loading screen
import 'package:flutter/material.dart'; // imported flutter material

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoadingScreen(), // route to LoadingScreen as the initial screen
    );
  }
}
