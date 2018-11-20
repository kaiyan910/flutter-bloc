import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item.dart';
import '../repository/NewsRepository.dart';

class StoriesBloc {
  final _repository = NewsRepository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<Item>>>();

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<Item>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {

    _itemsFetcher.stream
        .transform(_itemsTransformer())
        .pipe(_itemsOutput);
  }

  clearCache() {
    return _repository.clearCache();
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    print(ids);
    _topIds.sink.add(ids);
  }

  dispose() {

    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }

  _itemsTransformer() {

    return ScanStreamTransformer(
      (Map<int, Future<Item>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<Item>>{},
    );
  }
}
