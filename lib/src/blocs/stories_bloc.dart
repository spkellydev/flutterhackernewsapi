import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async' show Future;

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  // Single application transformer
  Observable<Map<int, Future<ItemModel>>> items;
  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  // Getters to Streams
  //// outgoing data to be consumed by widgets
  Observable<List<int>> get topIds => _topIds.stream;
  //// to Sinks
  Function(int) get fetchItem => _items.sink.add;

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, int _) {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  void dispose() {
    _topIds.close();
    _items.close();
  }
}
