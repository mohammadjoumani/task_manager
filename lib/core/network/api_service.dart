import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/core/utils/resource/routes_manager.dart';
import 'package:task_manager_app/features/generic/presentation/main/view/task_manager_app.dart';

import 'constants_api.dart';
import 'error_handler.dart';

const String authorization = "Authorization";
const String defaultLanguage = "language";

class ApiService {
  final Dio _dio1;
  final Dio _dio2;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPref;

  ApiService(
    this._dio1,
    this._dio2,
    this._networkInfo,
    this._appPref,
  ) {
    _dio1.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  //region Init function for interceptor

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _networkInfo.isConnected) {
      String? token = _appPref.getToken();
      final language = _appPref.getAppLanguage();
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['language'] = language;
      return handler.next(options);
    } else {
      return handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: ResponseCode.noInternetConnection,
            statusMessage: ResponseMessage.noInternetConnection,
          ),
          error: ResponseMessage.noInternetConnection,
        ),
      );
    }
// Continue with the modified options
  }

  _onError(DioException e, ErrorInterceptorHandler handler) async {
    if (e.response?.statusCode == 401 && _appPref.isUserLogged()) {
      _refreshToken(e, handler);
    } else {
      handler.next(e);
    }
  }

  Future<void> _refreshToken(DioException e, ErrorInterceptorHandler handler) async {
    try {
      final refreshToken = _appPref.getRefreshToken();
      final response = await _dio2.post(
        ConstantsApi.refreshTokenUrl,
        data: {'refreshToken': refreshToken},
      );
      _appPref.setToken(response.data['token']);
      _appPref.setRefreshToken(response.data['refreshToken']);
      handler.resolve(await _dio1.fetch(e.requestOptions));
    } catch (error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          _logout();
          handler.reject(e);
        } else {
          handler.next(error);
        }
      } else {
        handler.next(e);
      }
    }
  }

  void _logout() {
    final context = navigatorKey?.currentState?.context;
    if (context!.mounted) {
      _appPref.logout();
      Navigator.pushNamedAndRemoveUntil(context, Routes.splashRoute, (route) => false);
    }
  }

  //endregion

  Future<dynamic> get({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, dynamic>? customHeaders,
  }) async {
    Map<String, dynamic> headers = {};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    var response = await _dio1.get(
      url,
      data: data,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> post({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, dynamic>? customHeaders,
  }) async {
    Map<String, dynamic> headers = {};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    var response = await _dio1.post(
      url,
      data: data,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> put({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, dynamic>? customHeaders,
  }) async {
    Map<String, dynamic> headers = {};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    var response = await _dio1.put(
      url,
      data: data,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> patch({
    required String url,
    dynamic data,
    dynamic params,
    Map<String, dynamic>? customHeaders,
  }) async {
    Map<String, dynamic> headers = {};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    var response = await _dio1.patch(
      url,
      data: data,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return response.data;
  }

  Future<dynamic> delete({required String url}) async {
    var response = await _dio1.delete(url);
    return response.data;
  }

  Future<dynamic> downloadFile({required String url, dynamic data, dynamic params}) async {
    var response = await _dio1.get(
      url,
      queryParameters: params,
      onReceiveProgress: (received, total) {
        // print("Received: ${(received / total) * 100}");
      },
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }

// Future<String?> getTokenFromSelectedPayer() async {
//   PayerModel? selectedPayer = await _appPref.getSelectedPayerData();
//   if (selectedPayer == null) {
//     return null;
//   } else {
//     return selectedPayer.token;
//   }
// }

// get payer name from selected payer
// Future<String?> getPayerNameFromSelectedPayer() async {
//   PayerModel? selectedPayer = await _appPref.getSelectedPayerData();
//   if (selectedPayer == null) {
//     return null;
//   } else {
//     return selectedPayer.payerName;
//   }
// }
}
