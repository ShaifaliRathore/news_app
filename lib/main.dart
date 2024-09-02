import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_clean_architecture_app/config/routes/routes.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_event.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_event.dart';
import 'package:news_bloc_clean_architecture_app/injection_container.dart';

import 'config/theme/theme.dart';
import 'features/news/presentation/pages/home/daily_news.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
          create: (BuildContext context) =>
              sl()..add(const GetRemoteArticlesEvent()),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (BuildContext context) =>
              sl()..add(const GetSavedArticleEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
