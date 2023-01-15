import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:promart_api/promart.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required PromartRepository promartRepository})
      : _promartRepository = promartRepository,
        super(
          promartRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(promartRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    _userSubscription = _promartRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final PromartRepository _promartRepository;
  late final StreamSubscription<dynamic> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
