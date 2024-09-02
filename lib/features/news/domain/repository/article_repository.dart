import 'package:news_bloc_clean_architecture_app/core/resource/data_state.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> insertArticle(ArticleEntity article);

  Future<void> deleteArticle(ArticleEntity article);
}
