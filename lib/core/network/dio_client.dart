import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.openRouterBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    return _instance!;
  }
}