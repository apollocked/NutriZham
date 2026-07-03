import 'package:nutrizham/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<void> call() => repository.logout();
}
