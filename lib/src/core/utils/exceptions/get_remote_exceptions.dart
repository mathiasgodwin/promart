class GetRemoteException implements Exception {
  const GetRemoteException([this.message = 'Request could not be made.']);

  final String message;
}
