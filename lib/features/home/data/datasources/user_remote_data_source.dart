import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:two_ticket/core/constants/constants.dart';
import 'package:two_ticket/features/home/data/domain/model/ask_payment_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/member_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/payment_map_dto.dart';
import 'package:two_ticket/features/home/data/domain/model/quota_dto.dart';

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
  Future<HttpResponse<MemberDTO>> getUserData(
    @Header('Cookie') String cookie,
  );

  @GET(endpointPayments)
  Future<HttpResponse<List<QuotaDTO>>> getQuotas(
    @Header('Cookie') String cookie,
  );

  @GET(endpointPaymentMaps)
  Future<HttpResponse<List<PaymentMapDTO>>> getPaymentMaps(
    @Header('Cookie') String cookie,
  );

  @POST(endpointAskPayment)
  Future<HttpResponse<AskPaymentDTO>> askPayment(
    @Header('Cookie') String cookie,
    @Header('Content-Type') String contentType,
    @Body() AskPaymentDTO askPaymentDTO,
  );
}
