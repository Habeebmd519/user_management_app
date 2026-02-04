import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/blocs/buttonBloc/button_bloc.dart';
import 'package:user_management_app/features/blocs/buttonBloc/button_event.dart';
import 'package:user_management_app/features/blocs/checkBoxBoc/check_bloc.dart';
import 'package:user_management_app/features/blocs/checkBoxBoc/check_state.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_cubit.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_state.dart';

class PremiumAnimatedButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const PremiumAnimatedButton({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.label,
    this.onTap,
    required this.emailController,
    required this.passwordController,
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
          onTap: () async {
            if (!isSelected) {
              onTap?.call();
              return;
            }

            if (index == 0) return;

            final isTermsAccepted = context.read<TermsBloc>().state.accepted;
            if (!isTermsAccepted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please accept terms and conditions"),
                ),
              );
              return;
            }

            if (emailController.text.isEmpty ||
                passwordController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Invalid email or password (min 6 chars)"),
                ),
              );
              return;
            }

            await cubit.startLoading();
            onTap?.call();
          },
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
                child: state.isLoading
                    ? const SizedBox(
                        key: ValueKey("loader"),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : isSelected
                    ? Text(
                        label,
                        key: const ValueKey("text"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
