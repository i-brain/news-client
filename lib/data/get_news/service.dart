import 'response.dart';
import 'repository.dart';

abstract class INewsService {
  Future<GetNewsResponse> getAll([int? categoryId]);
  Future<GetNewsResponse> getTrendingNews();
}

class NewsService implements INewsService {
  NewsService(this.repository);
  final INewsRepository repository;
  @override
  Future<GetNewsResponse> getAll([int? categoryId]) {
    return repository.getAll(categoryId);
  }

  @override
  Future<GetNewsResponse> getTrendingNews() {
    return repository.getTrendingNews();
  }
}
