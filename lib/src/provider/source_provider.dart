import '../models/item.dart';

abstract class SourceProvider {
  Future<List<int>> fetchTopIds();
  Future<Item> fetchItem(int id);
}