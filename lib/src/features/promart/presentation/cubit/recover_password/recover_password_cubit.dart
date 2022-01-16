import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recover_password_state.dart';

class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  RecoverPasswordCubit() : super(RecoverPasswordLoading());
}
