import 'package:either_dart/either.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/power.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/power.dart';

class ViewPower extends UseCase<Power, NoParams> {
  final PowerRepository repository;

  ViewPower(this.repository);

  @override
  Future<Either<Failure, Power>> call(NoParams params) async {
    return await repository.getPower();
  }
}
