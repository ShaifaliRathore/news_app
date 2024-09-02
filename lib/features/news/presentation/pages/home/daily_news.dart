import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/remote_bloc/remote_article_state.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticleLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteArticleLoadedState) {
          return ListView.builder(
              itemCount: state.articles?.length,
              itemBuilder: (context, index) {
                return ArticleWidget(
                  article: state.articles?[index],
                  onArticlePressed: (article) =>
                      _onArticlePressed(context, article),
                );
              });
        }

        if (state is RemoteArticleErrorState) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
        return const SizedBox();
      },
    );
  }

  _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
