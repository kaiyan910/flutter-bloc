import 'package:flutter/material.dart';
import 'package:news/src/locale/custom_localization.dart';
import 'package:news/src/locale/custom_localization_delegate.dart';
import '../bloc/stories_provider.dart';
import '../bloc/comments_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/i18n.dart';

import 'news_list.dart';
import 'news_details.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  CustomLocalizationDelegate _customLocalizationDelegate;

  @override
  void initState() {

    super.initState();

    _customLocalizationDelegate = CustomLocalizationDelegate(null);
    customLocalization.onLocaleChanged = _onLocaleChange;

    _loadLocaleFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          localizationsDelegates: [
            _customLocalizationDelegate,
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: _routes,
        ),
      ),
    );
  }

  Route _routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final itemId =
        int.parse(settings.name.replaceFirst("/news_details/", ""));
        final commentsBloc = CommentsProvider.of(context);
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetails(itemId);
      });
    }
  }

  _loadLocaleFromPreferences() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String locale = preferences.getString("locale");

    print('locale=$locale');

    setState(() {
      if (locale != null && locale.isNotEmpty) {
        _customLocalizationDelegate = CustomLocalizationDelegate(new Locale(locale));
      }
    });
  }

  _onLocaleChange(Locale locale) {
    setState(() {
      _customLocalizationDelegate = CustomLocalizationDelegate(locale);
    });
  }
}