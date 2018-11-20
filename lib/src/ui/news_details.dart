import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/ui/loading_container.dart';

import '../bloc/comments_provider.dart';
import '../models/item.dart';
import 'comment.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
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

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(Item item, Map<int, Future<Item>> itemMap) {

    final children = <Widget>[];

    final commentList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        depth: 0,
        itemMap: itemMap,
      );
    }).toList();

    children.add(buildTitle(item));
    children.addAll(commentList);

    return new ListView(
      children: children,
    );
  }

  Widget buildTitle(Item item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
