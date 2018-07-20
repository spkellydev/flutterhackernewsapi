import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_text.dart';
import '../models/item_model.dart';
import '../widgets/loader_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final comment = snapshot.data;
        final commentChildren = <Widget>[
          ListTile(
            title: buildText(comment),
            subtitle: comment.by == "" ? Text('deleted') : Text(comment.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider(),
        ];
        comment.kids.forEach((kidId) {
          commentChildren.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: commentChildren,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&quot;', '"')
        .replaceAll('&gt;', '')
        .replaceAll('&lt;', '')
        .replaceAll('&#x2F;', '/');

    return HtmlText(
      data: text,
    );
  }
}
