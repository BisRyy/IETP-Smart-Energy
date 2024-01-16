import 'package:either_dart/either.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/user.dart';

import '../../../../../core/errors/failure.dart';

class LogOut extends UseCase<void, NoParams> {
  final UserRepository repository;

  LogOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logOut();
  }
}
