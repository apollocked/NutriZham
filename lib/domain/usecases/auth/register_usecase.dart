import 'package:nutrizham/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String username,
    required String email,
    required String password,
    required int age,
  }) {
    return repository.register(
      username: username,
      email: email,
      password: password,
      age: age,
    );
  }
}
