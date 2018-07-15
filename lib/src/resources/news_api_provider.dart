import 'package:http/http.dart' show Client;
import 'dart:convert' show json;
import 'dart:async' show Future;
import '../models/item_model.dart';
import 'repository.dart' show Source;

class NewsAPIProvider implements Source {
  Client client = Client();
  final String _root = 'https://hacker-news.firebaseio.com';

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/v0/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/v0/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
