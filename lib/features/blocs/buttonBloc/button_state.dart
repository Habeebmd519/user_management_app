enum AuthButton { info, login, signup }

class ButtonState {
  final AuthButton selectedButton;

  const ButtonState({required this.selectedButton});

  ButtonState copyWith({AuthButton? selectedButton}) {
    return ButtonState(selectedButton: selectedButton ?? this.selectedButton);
  }
}
