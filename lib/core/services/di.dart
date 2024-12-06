import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/get_category/repository.dart';
import '../../data/get_category/service.dart';
import '../../data/get_news/repository.dart';
import '../../data/get_news/service.dart';
import '../constants/config.dart';
import 'interceptor.dart';
import 'secure_storage.dart';

final getIt = GetIt.instance;

final dioWithoutToken = Dio()
  ..interceptors.add(AuthInterceptor())
  ..options = BaseOptions(
    baseUrl: Config.baseUrl,
    followRedirects: false,
    validateStatus: (status) => status! < 500,
  );
final dio = Dio()
  ..interceptors.add(JwtInterceptor())
  ..options = BaseOptions(
    baseUrl: Config.baseUrl,
    followRedirects: false,
    validateStatus: (status) {
      // getIt<LoginCubit>().checkAuthentication(status);
      return status! < 500;
    },
  );

Future<void> initializeDependencies() async {
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  getIt.registerLazySingleton<INewsRepository>(
    () => NewsRepository(dioWithoutToken),
  );
  getIt.registerLazySingleton<INewsService>(() => NewsService(getIt()));

  getIt.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepository(dio),
  );
  getIt.registerLazySingleton<ICategoryService>(() => CategoryService(getIt()));
}
