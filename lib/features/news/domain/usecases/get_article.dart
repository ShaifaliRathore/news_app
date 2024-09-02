import 'package:news_bloc_clean_architecture_app/core/resource/data_state.dart';
import 'package:news_bloc_clean_architecture_app/core/usecase/usecase.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/repository/article_repository.dart';

class GetArticleUsecase
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUsecase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
