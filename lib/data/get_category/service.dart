import 'response.dart';
import 'repository.dart';

abstract class ICategoryService {
  Future<GetCategoryResponse> getAll();
}

class CategoryService implements ICategoryService {
  CategoryService(this.repository);
  final ICategoryRepository repository;
  @override
  Future<GetCategoryResponse> getAll() {
    return repository.getAll();
  }
}
