library dio_network_exceptions;

import 'dart:io';

import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = "Unexpected error occurred"]);

  factory NetworkException.fromError(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return const NetworkException("Request Cancelled");
            case DioErrorType.connectTimeout:
              return const NetworkException("Connection request timeout");

            case DioErrorType.other:
              return const NetworkException("No internet connection");

            case DioErrorType.receiveTimeout:
              return const NetworkException(
                  "Send timeout in connection with API server");

            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  return const NetworkException("Unauthorised request");

                case 401:
                  return const NetworkException("Unauthorised request");

                case 403:
                  return const NetworkException("Unauthorised request");

                case 404:
                  return const NetworkException("404 Not Found");

                case 409:
                  return const NetworkException("Error due to a conflict");

                case 408:
                  return const NetworkException("Connection request timeout");
                case 500:
                  return const NetworkException("Internal Server Error");
                case 503:
                  return const NetworkException("Service unavailable");
                default:
                  var responseCode = error.response?.statusCode;

                  return NetworkException(
                      "Received invalid status code: $responseCode");
              }

            case DioErrorType.sendTimeout:
              return const NetworkException(
                  "Send timeout in connection with API server");
          }
        } else if (error is SocketException) {
          return const NetworkException("No internet connection");
        } else {
          return const NetworkException("Unexpected error occurred");
        }
      } on FormatException catch (e) {
        return const NetworkException("Unexpected error occurred");
      } catch (_) {
        return const NetworkException("Unexpected error occurred");
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkException("Unable to process the data");
      } else {
        return const NetworkException("Unexpected error occurred");
      }
    }
  }
}
