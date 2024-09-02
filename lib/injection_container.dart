import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/data_sources/local/app_database.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/repository/article_repository_impl.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/repository/article_repository.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/delete_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/get_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/get_saved_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/insert_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsAPIService>(NewsAPIService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerSingleton<GetArticleUsecase>(GetArticleUsecase(sl()));

  sl.registerSingleton<GetSavedArticleUsecase>(GetSavedArticleUsecase(sl()));

  sl.registerSingleton<InsertArticleUsecase>(InsertArticleUsecase(sl()));

  sl.registerSingleton<DeleteArticleUsecase>(DeleteArticleUsecase(sl()));

  sl.registerSingleton<RemoteArticleBloc>(RemoteArticleBloc(sl()));

  sl.registerSingleton<LocalArticleBloc>(LocalArticleBloc(sl(), sl(), sl()));
}
