import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:two_ticket/core/constants/constants.dart';
import 'package:two_ticket/core/constants/dependencies/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @Named("baseUrl")
  String get baseUrl => apiBaseURL;

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
