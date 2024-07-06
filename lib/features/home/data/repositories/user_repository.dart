import 'package:two_ticket/features/home/data/datasources/local_data_source.dart';
import 'package:two_ticket/features/home/data/datasources/user_remote_data_source.dart';
import 'package:two_ticket/features/home/data/domain/model/user_model.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<User> getUserData(String cookie) async {
    final response = await remoteDataSource.getUserData(
      cookie,
    );
    return User.fromJson(
      response.data,
    );
  }
}
