import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'Hacker News',
        home: NewsList(),
      ),
    );
  }
}
