import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'promart_state.dart';

class PromartCubit extends Cubit<PromartState> {
  PromartCubit() : super(PromartInitial());
}

