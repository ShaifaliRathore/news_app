import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_clean_architecture_app/core/resource/data_state.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/usecases/get_article.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_event.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUsecase _getArticleUsecase;

  RemoteArticleBloc(this._getArticleUsecase)
      : super(const RemoteArticleLoadingState()) {
    on<GetRemoteArticlesEvent>(getRemoteArticles);
  }

  Future<void> getRemoteArticles(
      GetRemoteArticlesEvent event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUsecase();
    if (dataState is DataSuccessState && dataState.data!.isNotEmpty) {
      emit(RemoteArticleLoadedState(dataState.data!));
    }

    if (dataState is DataErrorState) {
      emit(RemoteArticleErrorState(dataState.error!));
    }
  }
}
