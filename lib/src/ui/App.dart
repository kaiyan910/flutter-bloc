import 'package:flutter/material.dart';
import 'package:news/src/ui/news_list.dart';
import '../bloc/stoires_provider.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
