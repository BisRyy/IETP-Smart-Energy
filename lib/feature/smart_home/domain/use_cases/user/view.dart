import 'package:either_dart/either.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/entities/user.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/user.dart';

import '../../../../../core/errors/failure.dart';

class GetUser extends UseCase<User, NoParams> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
