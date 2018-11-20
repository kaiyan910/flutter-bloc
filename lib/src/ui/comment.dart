import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<Item>> itemMap;

  Comment({this.itemId, this.depth, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<Item> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: depth * 16.0 + 16.0,
              right: 16.0,
            ),
            title: buildText(snapshot.data),
            subtitle: Text('${snapshot.data.by}'),
          ),
          Divider(
            height: 8.0,
          ),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              depth: depth + 1,
              itemMap: itemMap,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }
  
  Widget buildText(Item item) {
    
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    
    return Text('$text');
  }
}
