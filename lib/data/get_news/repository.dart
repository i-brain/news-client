import 'package:dio/dio.dart';
import 'response.dart';

abstract class INewsRepository {
  Future<GetNewsResponse> getAll([int? categoryId]);
  Future<GetNewsResponse> getTrendingNews();
}

class NewsRepository implements INewsRepository {
  NewsRepository(this.dio);
  final Dio dio;

  @override
  Future<GetNewsResponse> getAll([int? categoryId]) async {
    final path = categoryId == null ? "/news" : "/news/category/$categoryId";
    final result = await dio.get(path);
    print(result);
    return GetNewsResponse.fromJson(result.data);
  }

  @override
  Future<GetNewsResponse> getTrendingNews() async {
    final result = await dio.get("/news");
    return GetNewsResponse.fromJson(result.data);
  }
}
