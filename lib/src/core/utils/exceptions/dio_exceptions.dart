class DioException implements Exception {
  String errorMessage;
  DioException([this.errorMessage = 'There was an internal error, try again!']);
}
