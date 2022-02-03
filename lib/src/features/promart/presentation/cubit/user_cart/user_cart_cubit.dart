import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_cart_state.dart';

class UsersCartCubit extends Cubit<UsersCartState> {
  UsersCartCubit() : super(UsersCartInitial());

  
}
