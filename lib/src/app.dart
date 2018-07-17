import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'Hacker News',
        home: NewsList(),
        onGenerateRoute: (RouteSettings settings) {
          // using MaterialApp navigator class
          return routes(settings);
        },
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsDetail();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('More Detail'),
            ),
            body: Text('Im a details screen'),
          );
        },
      );
    }
  }
}
