import 'package:news_bloc_clean_architecture_app/core/usecase/usecase.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/repository/article_repository.dart';

class DeleteArticleUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  DeleteArticleUsecase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.deleteArticle(params!);
  }
}
