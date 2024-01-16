
import 'package:either_dart/either.dart';
import 'package:smart_home/core/errors/failure.dart';
import 'package:smart_home/feature/smart_home/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(
      {required String phone, required String password});
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> createUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  });

  Future<Either<Failure, void>> logOut();
}
