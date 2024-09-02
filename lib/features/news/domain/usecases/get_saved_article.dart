import 'package:news_bloc_clean_architecture_app/core/usecase/usecase.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/repository/article_repository.dart';

class GetSavedArticleUsecase implements Usecase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUsecase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
