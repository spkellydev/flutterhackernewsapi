import 'package:http/http.dart' show Client;
import 'dart:convert' show json;
import '../models/item_model.dart';

class NewsAPIProvider {
  Client client = Client();
  final String _root = 'https://hacker-news.firebaseio.com';

  fetchTopIds() async {
    final response = await client.get('$_root/v0/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/v0/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
