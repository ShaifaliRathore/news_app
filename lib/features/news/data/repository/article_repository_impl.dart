import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_bloc_clean_architecture_app/core/constants/constants.dart';
import 'package:news_bloc_clean_architecture_app/core/resource/data_state.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/data_sources/local/app_database.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/models/article_model.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsAPIService _newsAPIService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsAPIService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsAPIService.getNewsArticles(
          apiKey: newsAPIKey, country: newsCountry, category: newsCategory);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccessState(httpResponse.data);
      } else {
        return DataErrorState(DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage));
      }
    } on DioException catch (e) {
      return DataErrorState(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> insertArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
