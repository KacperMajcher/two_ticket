import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:two_ticket/core/constants/constants.dart';

part 'user_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseURL)
@injectable
abstract class UserRemoteDataSource {
  @factoryMethod
  factory UserRemoteDataSource(
    Dio dio, {
    @Named('baseUrl') String baseUrl,
  }) = _UserRemoteDataSource;

  @GET(endpointUserMemberData)
  Future<HttpResponse> getUserData(
    @Header('Cookie') String cookie,
  );
}
