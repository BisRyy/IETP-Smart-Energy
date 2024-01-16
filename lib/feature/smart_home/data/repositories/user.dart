
import 'package:either_dart/either.dart';
import 'package:smart_home/core/errors/exception.dart';
import 'package:smart_home/core/errors/failure.dart';
import 'package:smart_home/feature/smart_home/data/data_source/local/user.dart';
import 'package:smart_home/feature/smart_home/data/data_source/remote/user.dart';
import 'package:smart_home/feature/smart_home/domain/entities/user.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/user.dart';

import '../../../../core/network/info.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User>> createUser(
      {required String firstName,
      required String lastName,
      required String phone,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.createUser(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          password: password,
        );

        final token = await remoteDataSource.login(phone, password);
        user.copyWith(token: token);
        await localDataSource.cacheUser(user);

        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String phone, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.login(
          phone,
          password,
        );
        var user = await remoteDataSource.getUser(token);

        user = user.copyWith(token: token);

        await localDataSource.cacheUser(user);

        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await localDataSource.deleteUser();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
