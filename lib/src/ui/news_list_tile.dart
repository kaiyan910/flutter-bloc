import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../bloc/stoires_provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {

  final int itemId;

  NewsListTile(this.itemId);

  @override
  Widget build(BuildContext context) {

    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<Item>>> snapshot) {

        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<Item> itemSnapshot) {

            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(Item item) {

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(height: 8.0),
      ],
    );
  }
}
