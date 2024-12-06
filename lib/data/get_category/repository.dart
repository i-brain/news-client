import 'package:dio/dio.dart';
import 'response.dart';

abstract class ICategoryRepository {
  Future<GetCategoryResponse> getAll();
}

class CategoryRepository implements ICategoryRepository {
  CategoryRepository(this.dio);
  final Dio dio;

  @override
  Future<GetCategoryResponse> getAll() async {
    final result = await dio.get('/category');
    return GetCategoryResponse.fromJson(result.data);
  }
}
