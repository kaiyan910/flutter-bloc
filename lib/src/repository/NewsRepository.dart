import 'dart:async';

import 'package:news/src/provider/cache_provider.dart';
import 'package:news/src/provider/source_provider.dart';

import '../provider/news_api_provider.dart';
import '../provider/news_database_provider.dart';
import '../models/item.dart';

class NewsRepository {

  List<SourceProvider> sources = <SourceProvider> [
    NewsApiProvider(),
    newsDatabaseProvider,
  ];

  List<CacheProvider> caches = <CacheProvider> [
    newsDatabaseProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[0].fetchTopIds();
  }

  Future<Item> fetchItem(int id) async {

    Item item;
    SourceProvider source;

    for (source in sources) {

      item = await source.fetchItem(id);
      if (item != null) {

        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}