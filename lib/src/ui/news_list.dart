import 'package:flutter/material.dart';
import 'package:news/generated/i18n.dart';
import 'package:news/src/locale/custom_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/stories_provider.dart';
import 'news_list_tile.dart';
import 'refresh.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {

              customLocalization.onLocaleChanged(Locale('en', ''));
              bloc.updateLocale('en');
            },
          ),
          IconButton(
            icon: Icon(Icons.g_translate),
            onPressed: () {

              customLocalization.onLocaleChanged(Locale('zh', ''));
              bloc.updateLocale('zh');
            },
          ),
        ],
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {

    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(snapshot.data[index]);
            },
          ),
        );
      },
    );
  }

}
