import 'package:user_management_app/features/blocs/buttonBloc/button_state.dart';

abstract class ButtonEvent {}

class AuthButtonPressed extends ButtonEvent {
  final AuthButton button;
  AuthButtonPressed(this.button);
}
