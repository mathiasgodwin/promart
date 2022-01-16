class PostRemoteException implements Exception {
  const PostRemoteException([this.message = 'Unable to send data']);

  final String message;
}
