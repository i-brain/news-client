import 'package:news_client/data/auth/register/request.dart';
import 'login/request.dart';
import 'repository.dart';

abstract class IAuthService {
  Future<void> register(RegisterRequest request);
  Future<void> login(LoginRequest request);
  Future<void> logout();
}

class AuthService implements IAuthService {
  AuthService(this.repository);
  final IAuthRepository repository;

  @override
  Future<void> register(RegisterRequest request) {
    return repository.register(request);
  }

  @override
  Future<void> login(LoginRequest request) {
    return repository.login(request);
  }

  @override
  Future<void> logout() {
    return repository.logout();
  }
}
