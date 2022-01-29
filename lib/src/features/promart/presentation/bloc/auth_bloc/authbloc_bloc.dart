import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:promart/src/features/promart/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:promart/src/features/promart/data/repositories/promart_repository.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required PromartRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final PromartRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
