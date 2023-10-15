import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nio_demo/tools/logger.dart';

class LoggingPathInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logit('REQUEST[${options.method}] => URL: ${options.baseUrl + options.path}'
        '\nHEADERS:${options.headers}'
        '\nQUERY:${options.queryParameters}'
        '\nBODY: ${jsonEncode(options.data)}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logit(
        'RESPONSE[${response.statusCode}] <= URL: ${response.requestOptions.baseUrl + response.requestOptions.path}'
        '\nTYPE: ${response.requestOptions.responseType.name}'
        '\nQUERY:${response.requestOptions.queryParameters}'
        '\nBODY: ${jsonEncode(response.data)}'
        '');
    // var data = response.data;

    // if (data is Map) {
    //   var responseBody = data['response'].toString();

    // if (responseBody.equals(StringConstants.unauthorized, true)){
    //   // response.data.remove('response');
    //   // handler.next(response);
    //
    //   handler.reject(DioError(
    //       requestOptions: response.requestOptions,
    //       error: StringConstants.unauthorized,
    //       type: DioErrorType.response));
    //   return;
    // }
    // }
    // if(response.statusCode == 401){
    //   handler.reject(DioError(
    //     requestOptions: response.requestOptions,
    //     response: response,
    //     error: StringConstants.unauthorized,
    //   ));

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logit(
        'ERROR[${err.response?.statusCode}] <= URL: ${err.requestOptions.baseUrl + err.requestOptions.path}'
        '\nTYPE: ${err.response?.requestOptions.responseType.name}'
        '\nBODY: ${err.response?.data}'
        '\nERROR: ${err.error}');
    super.onError(err, handler);
  }
}
