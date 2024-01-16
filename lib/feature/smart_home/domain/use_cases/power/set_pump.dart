import 'package:either_dart/either.dart';
import 'package:smart_home/core/use_cases/usecase.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/power.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/pump.dart';

class SetPump extends UseCase<Pump, Params> {
  final PowerRepository repository;

  SetPump(this.repository);

  @override
  Future<Either<Failure, Pump>> call(Params params) async {
    return await repository.setPump(params.pump);
  }
}

class Params {
  final String pump;

  const Params({
    required this.pump,
  });
}
