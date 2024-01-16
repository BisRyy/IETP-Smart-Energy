import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/power.dart';
import '../../data/model/pump.dart';

abstract class PowerRepository {
  Future<Either<Failure, PowerModel>> getPower();
  Future<Either<Failure, PumpModel>> setPump(String pump);
  Future<Either<Failure, PumpModel>> getPump();
}
