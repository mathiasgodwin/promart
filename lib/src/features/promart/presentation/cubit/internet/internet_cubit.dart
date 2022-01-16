import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity? connectivity;
  StreamSubscription? connectivityStreamSubscription;
  InternetCubit({required this.connectivity})
      : assert(connectivity != null),
        super(InternetLoading()) {
    connectivityStreamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(const InternetConnected(connectionType: ConnectionType.wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(const InternetConnected(connectionType: ConnectionType.mobile));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDiscornnected());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
