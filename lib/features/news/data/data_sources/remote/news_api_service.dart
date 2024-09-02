import 'package:dio/dio.dart';
import 'package:news_bloc_clean_architecture_app/core/constants/constants.dart';
import 'package:news_bloc_clean_architecture_app/features/news/data/models/article_model.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsAPIService {
  factory NewsAPIService(Dio dio) = _NewsAPIService;

  @GET(newsAPIPath)
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles(
      {@Query("apiKey") String? apiKey,
      @Query("country") String? country,
      @Query("category") String? category});
}
