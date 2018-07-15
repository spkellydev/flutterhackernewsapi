import 'package:hacker_news_api/src/resources/news_api_provider.dart';
import 'dart:convert' show json;
import 'package:test/test.dart' show test, expect;
import 'package:http/http.dart' show Request, Response;
import 'package:http/testing.dart' show MockClient;

void main() {
  test('fetchTopIds returns a list of ids', () async {
    // setup of test case
    final List<int> ids = [1, 2, 3, 4, 5];
    final newsApi = NewsAPIProvider();
    newsApi.client = MockClient((Request request) async {
      return Response(json.encode(ids), 200);
    });

    // expectation
    final fetchedIds = await newsApi.fetchTopIds();
    expect(fetchedIds, ids);
  });

  test('fetchItem returns an ItemModel', () async {
    final newsApi = NewsAPIProvider();
    newsApi.client = MockClient((Request request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
