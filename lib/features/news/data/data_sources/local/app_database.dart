import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/data_sources/local/DAO/article_dao.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/models/article_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 2, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
