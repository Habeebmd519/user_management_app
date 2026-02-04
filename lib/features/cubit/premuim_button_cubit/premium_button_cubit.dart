import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_state.dart';

class PremiumButtonCubit extends Cubit<PremiumButtonState> {
  PremiumButtonCubit()
    : super(PremiumButtonState(isLoading: false, isPressed: false));
  void pressDown() => emit(state.copyWith(isPressed: true));
  void pressUp() => emit(state.copyWith(isPressed: false));

  Future<void> startLoading() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(isLoading: false));
  }
}
