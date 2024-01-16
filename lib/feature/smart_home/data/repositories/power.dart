import 'package:either_dart/src/either.dart';
import 'package:smart_home/core/errors/failure.dart';
import 'package:smart_home/feature/smart_home/data/model/power.dart';
import 'package:smart_home/feature/smart_home/data/model/pump.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/power.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/info.dart';
import '../data_source/remote/power.dart';

class PowerRepositoryImp implements PowerRepository {
  const PowerRepositoryImp({
    required this.powerRemoteDataSource,
    required this.networkInfo,
  });

  final PowerRemoteDataSource powerRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PowerModel>> getPower() async {
    if (await networkInfo.isConnected) {
      try {
        final power = await powerRemoteDataSource.getPower();
        return Right(power);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PumpModel>> getPump() async {
    if (await networkInfo.isConnected) {
      try {
        final pump = await powerRemoteDataSource.getPump();
        return Right(pump);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PumpModel>> setPump(String id) async {

    if (await networkInfo.isConnected) {
      try {
        final pump = await powerRemoteDataSource.setPump(id);
        return Right(pump);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
