import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/delete_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/get_saved_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/insert_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_event.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUsecase _getSavedArticleUsecase;
  final InsertArticleUsecase _insertArticleUsecase;
  final DeleteArticleUsecase _deleteArticleUsecase;

  LocalArticleBloc(this._getSavedArticleUsecase, this._insertArticleUsecase,
      this._deleteArticleUsecase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticleEvent>(onGetSavedArticleEvent);
    on<InsertArticleEvent>(onInsertArticleEvent);
    on<DeleteArticleEvent>(onDeleteArticleEvent);
  }

  FutureOr<void> onGetSavedArticleEvent(
      GetSavedArticleEvent event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUsecase();
    emit(LocalArticleLoaded(articles));
  }

  FutureOr<void> onInsertArticleEvent(
      InsertArticleEvent event, Emitter<LocalArticleState> emit) async {
    await _insertArticleUsecase(params: event.article);
    final articles = await _getSavedArticleUsecase();
    emit(LocalArticleLoaded(articles));
  }

  FutureOr<void> onDeleteArticleEvent(
      DeleteArticleEvent event, Emitter<LocalArticleState> emit) async {
    await _deleteArticleUsecase(params: event.article);
    final articles = await _getSavedArticleUsecase();
    emit(LocalArticleLoaded(articles));
  }
}
