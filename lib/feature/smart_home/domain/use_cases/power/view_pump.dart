import 'package:either_dart/either.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/entities/pump.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/power.dart';

import '../../../../../core/errors/failure.dart';

class ViewPump extends UseCase<Pump, NoParams> {
  final PowerRepository repository;

  ViewPump(this.repository);

  @override
  Future<Either<Failure, Pump>> call(NoParams params) async {
    return await repository.getPump();
  }
}
