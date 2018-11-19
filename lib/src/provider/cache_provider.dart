import 'package:news/src/models/item.dart';

abstract class CacheProvider {
  Future<int> addItem(Item item);
}