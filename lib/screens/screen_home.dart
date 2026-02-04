import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const Text(
                'Hey,',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Nice to see you',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Column(
            key: const ValueKey("signup"),
            children: [
              _buildField("Full Name", Icons.person),
              _buildField("Mobile Number", Icons.phone),
              _buildField("Email", Icons.email),
              _buildField("Password", Icons.lock, isPassword: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool isPassword = false}) {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    ValueNotifier<bool> obscure = ValueNotifier(isPassword);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ValueListenableBuilder<bool>(
        valueListenable: obscure,
        builder: (context, isObscured, _) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: isObscured,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: hint,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              prefixIcon: Icon(icon),

              // 👇 Password show/hide
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => obscure.value = !isObscured,
                    )
                  : null,

              filled: true,
              fillColor: Colors.grey.shade100,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          );
        },
      ),
    );
  }
}
