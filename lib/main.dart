import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/core/di/injection.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/screens/timers_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for GetIt setup
  await configureDependencies(); // Call the function to set up GetIt with injectable
  HydratedBloc.storage = getIt<HydratedStorage>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TimersBloc>(),
      child: MaterialApp(
        title: 'Timer App',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const TimersListScreen(),
      ),
    );
  }
}
