import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';
import '../bloc/comments_provider.dart';

import 'news_list.dart';
import 'news_details.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {

    if (settings.name == "/") {

      return MaterialPageRoute(
          builder: (context) {
            final storiesBloc = StoriesProvider.of(context);
            storiesBloc.fetchTopIds();
            return NewsList();
          }
      );

    } else {

      return MaterialPageRoute(
          builder: (context) {
            final itemId = int.parse(settings.name.replaceFirst("/news_details/", ""));
            final commentsBloc = CommentsProvider.of(context);
            print('details page id = ${itemId}');
            commentsBloc.fetchItemWithComments(itemId);
            return NewsDetails(itemId);
          }
      );
    }
  }
}
