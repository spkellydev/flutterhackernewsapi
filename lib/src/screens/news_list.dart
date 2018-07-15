import 'package:flutter/material.dart';
import 'dart:async' show Future;

class NewsList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
              height: 80.0,
              child: snapshot.hasData
                  ? Text('im visible $index')
                  : Text('I havent fetched data yet $index'),
            );
          },
        );
      },
    );
  }

  Future getFuture() {
    return Future.delayed(Duration(seconds: 2), () => 'hi');
  }
}
