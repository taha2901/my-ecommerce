// import 'package:ecommerce_app/core/routings/routers.dart';
// import 'package:ecommerce_app/features/auth/data/user_data.dart';
// import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
// import 'package:flutter/material.dart';

// class AdminGuard extends StatelessWidget {
//   final Widget child;
//   final AuthCubit authCubit;

//   const AdminGuard({
//     Key? key,
//     required this.child,
//     required this.authCubit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<UserData?>(
//       future: authCubit.getCurrentUser(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         if (snapshot.hasError || !snapshot.hasData) {
//           // المستخدم غير مسجل دخول
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.of(context).pushReplacementNamed(Routers.loginRoute);
//           });
//           return const SizedBox.shrink();
//         }

//         final user = snapshot.data!;
//         if (user.role != 'admin') {
//           // المستخدم ليس أدمن
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.of(context).pushReplacementNamed(Routers.homeRoute);
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('ليس لديك صلاحيات للوصول لهذه الصفحة'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           });
//           return const SizedBox.shrink();
//         }

//         // المستخدم أدمن - اعرض الصفحة
//         return child;
//       },
//     );
//   }
// }