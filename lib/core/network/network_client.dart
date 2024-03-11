import 'package:dio/dio.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkClient {
  late final Dio _dio;

  NetworkClient(Dio dio, String baseUrl) {
    _dio = dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (_) => true,
        connectTimeout: const Duration(milliseconds: 50000),
        receiveTimeout: const Duration(milliseconds: 50000),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
  }

  Future<Map<String, dynamic>> get(
    path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    final Map<String, dynamic> headers = {};
    if (token != null) headers['Authorization'] = token;
    try {
      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.statusCode != null &&
          response.statusCode! < 300 &&
          response.data['status'] < 300) {
        return response.data;
      } else {
        throw ServerException(response.data['message']);
      }
    } on DioException catch (e) {
      throw (ServerException(_handleDioException(e)));
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    bool hashRequestBody = false,
    Object? data,
    String? token,
  }) async {
    final Map<String, dynamic> headers = {};
    if (token != null) headers['Authorization'] = token;

    try {
      Response response = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      if (response.statusCode != null &&
          response.statusCode! < 300 &&
          response.data['status'] < 300) {
        return response.data;
      } else {
        throw ServerException(response.data['message']);
      }
    } on DioException catch (e) {
      throw (ServerException(_handleDioException(e)));
    }
  }

  String _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.sendTimeout:
        return "Url is sent timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badCertificate:
        return "Bad certificate";
      case DioExceptionType.badResponse:
        return "Bad response";
      case DioExceptionType.cancel:
        return "Request is cancelled";
      case DioExceptionType.connectionError:
        return "connectionError";
      default:
        return exception.message ?? "Unknown error";
    }
  }
}
