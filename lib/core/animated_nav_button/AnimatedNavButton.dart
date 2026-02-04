import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_cubit.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_state.dart';

class PremiumAnimatedButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const PremiumAnimatedButton({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return BlocBuilder<PremiumButtonCubit, PremiumButtonState>(
      builder: (context, state) {
        final cubit = context.read<PremiumButtonCubit>();

        return GestureDetector(
          onTapDown: (_) => cubit.pressDown(),
          onTapUp: (_) => cubit.pressUp(),
          onTapCancel: () => cubit.pressUp(),
          onTap: onTap,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 120),
            scale: state.isPressed ? 0.92 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              width: state.isLoading ? 56 : (isSelected ? 120 : 56),
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isSelected
                    ? GestureDetector(
                        onTap: () async {
                          await cubit.startLoading();
                        },

                        child: state.isLoading
                            ? const SizedBox(
                                key: ValueKey("loader"),
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                label,
                                key: const ValueKey("text"),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )
                    : Icon(
                        icon,
                        key: const ValueKey("icon"),
                        color: Colors.grey.shade700,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
