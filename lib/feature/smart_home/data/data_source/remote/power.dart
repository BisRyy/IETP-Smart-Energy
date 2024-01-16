import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home/core/errors/exception.dart';
import 'package:smart_home/feature/smart_home/data/model/pump.dart';

import '../../model/power.dart';

abstract class PowerRemoteDataSource {
  Future<PowerModel> getPower();
  Future<PumpModel> setPump(String pump);
  Future<PumpModel> getPump();
}

class PowerRemoteDataSourceImpl implements PowerRemoteDataSource {
  final http.Client client;
  final String baseurl = "http://activator.duresa.com.et/";

  PowerRemoteDataSourceImpl({required this.client});

  @override
  Future<PowerModel> getPower() async {
    final response = await client.get(Uri.parse("${baseurl}outputs"));
    if (response.statusCode == 200) {
      return PowerModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PumpModel> getPump() async {
    final response = await client.get(Uri.parse("${baseurl}pumps"));

    if (response.statusCode == 200) {
      return PumpModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PumpModel> setPump(String pump) async {
    final response = await client.get(
      Uri.parse("${baseurl}outputs/$pump"),
    );

    if (response.statusCode == 200) {
      return PumpModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
