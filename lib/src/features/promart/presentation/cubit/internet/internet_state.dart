part of 'internet_cubit.dart';

enum ConnectionType {
  wifi,
  mobile,
}

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  const InternetConnected({required this.connectionType});
}

class InternetDiscornnected extends InternetState {}
