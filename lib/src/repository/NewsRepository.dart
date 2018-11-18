import 'dart:async';

import '../provider/news_api_provider.dart';
import '../provider/news_database_provider.dart';
import '../models/item.dart';

class NewsRepository {

  NewsDatabaseProvider newsDatabaseProvider;
  NewsApiProvider newsApiProvider;

  Future<List<int>> fetchTopIds() {
    return newsApiProvider.fetchTopIds();
  }

  Future<Item> fetchItem(int id) async {

    var item = await newsDatabaseProvider.fetchItem(id);

    if (item != null) return item;

    item = await newsApiProvider.fetchItem(id);

    newsDatabaseProvider.addItem(item);

    return item;
  }
}