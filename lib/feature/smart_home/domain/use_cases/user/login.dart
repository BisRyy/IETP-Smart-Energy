
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/entities/user.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/user.dart';

import '../../../../../core/errors/failure.dart';

class UserLogin extends UseCase<User, Params> {
  final UserRepository repository;

  UserLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.login(
        phone: params.phone, password: params.password);
  }
}

class Params extends Equatable {
  final String phone;
  final String password;

  const Params({
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, password];
}
