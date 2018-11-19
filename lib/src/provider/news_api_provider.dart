import 'package:http/http.dart' show Client;
import 'package:news/src/provider/source_provider.dart';
import 'dart:convert';
import '../models/item.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements SourceProvider {

  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
   
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    
    return ids.cast<int>();
  }

  @override
  Future<Item> fetchItem(int id) async {
    
    final response = await client.get('$_root/item/$id.json');
    final parsed = json.decode(response.body);

    return Item.fromJson(parsed);
  }
}