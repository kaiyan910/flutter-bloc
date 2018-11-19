import 'package:flutter/material.dart';
import 'package:news/src/ui/news_list.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      home: NewsList(),
    );
  }
}
