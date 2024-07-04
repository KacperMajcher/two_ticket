import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:two_ticket/core/constants/constants.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseURL)
@injectable
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(
    Dio dio, {
    @Named('baseUrl') String baseUrl,
  }) = _AuthRemoteDataSource;

  @POST(endpointLogin)
  Future<HttpResponse> login(
    @Body() Map<String, dynamic> body,
  );
}
