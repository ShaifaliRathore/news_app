import 'package:equatable/equatable.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articleList;

  const LocalArticleState({this.articleList});

  @override
  List<Object?> get props => [articleList];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleLoaded extends LocalArticleState {
  const LocalArticleLoaded(List<ArticleEntity> articleList)
      : super(articleList: articleList);
}
