import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_bloc_clean_architecture_app/features/news/domain/entities/article_entity.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_bloc.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_event.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/bloc/article/local_bloc/local_article_state.dart';
import 'package:news_bloc_clean_architecture_app/features/news/presentation/widgets/article_tile.dart';
import 'package:news_bloc_clean_architecture_app/injection_container.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.chevron_left, color: Colors.black),
        ),
      ),
      title:
          const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalArticleLoaded) {
          return _buildArticlesList(state.articleList!);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articleList) {
    if (articleList.isEmpty) {
      return const Center(
        child: Text(
          'NO SAVED ARTICLES',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articleList[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onArticlePressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    sl<LocalArticleBloc>().add(DeleteArticleEvent(article));
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
