import 'dart:developer';
import 'package:two_ticket/features/home/data/datasources/local_data_source.dart';
import 'package:two_ticket/features/home/data/datasources/user_remote_data_source.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<User> getUserData() async {
    final cookie = await localDataSource.getCookie();
    try {
      final response = await remoteDataSource.getUserData(cookie!);
      log('fetchUserData: ${response.data}');
      final memberDTO = response.data;
      final user = User.fromMemberDTO(
        cookie,
        memberDTO,
      );
      log('User created: $user');
      return user;
    } catch (e) {
      log('Error fetching user data: $e');
      rethrow;
    }
  }

  Future<List<QuotaDTO>> getQuotas(String cookie) async {
    try {
      log('Fetching quotas with cookie: $cookie');
      final response = await remoteDataSource.getQuotas(
        cookie,
      );
      log('fetchQuotas: ${response.data}');
      return response.data;
    } catch (e) {
      log('Error fetching quotas: $e');
      rethrow;
    }
  }

  Future<List<PaymentMapDTO>> getPaymentMaps(String cookie) async {
    try {
      final response = await remoteDataSource.getPaymentMaps(
        cookie,
      );
      log('fetchPaymentMaps: ${response.data}');
      return response.data;
    } catch (e) {
      log('Error fetching payment maps: $e');
      rethrow;
    }
  }
}
