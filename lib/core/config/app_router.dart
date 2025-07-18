// // app/config/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:odoo/features/timer/presentation/screens/create_timer_screen.dart';
// import 'package:odoo/features/timer/presentation/screens/list_timers_screen.dart';
// import 'package:odoo/features/timer/presentation/screens/task_details_screen.dart';

// class AppRoutes {
//   static const String home = '/';
//   static const String createTimer = '/create-timer';
//   static const String taskDetails = '/task-details/:taskId'; // Path parameter
// }

// class AppRouter {
//   static final GoRouter router = GoRouter(
//     routes: <RouteBase>[
//       GoRoute(
//         path: AppRoutes.home,
//         builder: (BuildContext context, GoRouterState state) {
//           return const ListTimersScreen();
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.createTimer,
//         builder: (BuildContext context, GoRouterState state) {
//           return const CreateTimerScreen();
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.taskDetails,
//         builder: (BuildContext context, GoRouterState state) {
//           final taskId =
//               state.pathParameters['taskId']; // Access path parameter
//           if (taskId != null) {
//             return TaskDetailsScreen(taskId: taskId);
//           }
//           // Handle case where taskId is null, perhaps navigate back or show error
//           return const Text('Error: Task ID not found'); // Or an error screen
//         },
//       ),
//     ],
//   );
// }
