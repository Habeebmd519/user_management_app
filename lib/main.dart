import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management_app/features/blocs/buttonBloc/button_bloc.dart';
import 'package:user_management_app/features/blocs/checkBoxBoc/check_bloc.dart';
import 'package:user_management_app/features/cubit/premuim_button_cubit/premium_button_cubit.dart';
import 'package:user_management_app/screens/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonBloc()),
        BlocProvider(create: (_) => TermsBloc()),
        BlocProvider(create: (_) => PremiumButtonCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: AnimatedLoginScreen(),
      ),
    );
  }
}
