import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/blocs/buttonBloc/button_event.dart';
import 'package:user_management_app/features/blocs/buttonBloc/button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(const ButtonState(selectedButton: AuthButton.login)) {
    on<AuthButtonPressed>((event, emit) async {
      // Hide first (for animation reset)
      emit(state.copyWith(selectedButton: event.button));

      await Future.delayed(const Duration(milliseconds: 30));
    });
  }
}
