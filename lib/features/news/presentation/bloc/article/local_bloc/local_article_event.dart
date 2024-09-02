import 'package:equatable/equatable.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticleEvent({this.article});

  @override
  List<Object?> get props => [article];
}

class GetSavedArticleEvent extends LocalArticleEvent {
  const GetSavedArticleEvent();
}

class InsertArticleEvent extends LocalArticleEvent {
  const InsertArticleEvent(ArticleEntity article) : super(article: article);
}

class DeleteArticleEvent extends LocalArticleEvent {
  const DeleteArticleEvent(ArticleEntity article) : super(article: article);
}
