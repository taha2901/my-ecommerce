// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_cubit.dart';
// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_states.dart';
// import 'package:ecommerce_app/features/profile/ui/edit_profile_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserProfilePage extends StatelessWidget {
//   const UserProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => UserCubit()..getUserData(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('الملف الشخصي')),
//         body: BlocBuilder<UserCubit, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               final user = state.user;
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("👤 Name : ${user.username}"),
//                     Text("📧 Email : ${user.email}"),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => BlocProvider.value(
//                               value: context.read<UserCubit>(),
//                               child: EditProfilePage(user: user),
//                             ),
//                           ),
//                         );
//                       },
//                       label: const Text("تعديل البيانات"),
//                     )
//                   ],
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(child: Text(state.message));
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:ecommerce_app/features/profile/logic/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/profile/logic/user_cubit/user_states.dart';
import 'package:ecommerce_app/features/profile/ui/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الملف الشخصي'),
          centerTitle: true,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // صورة رمزية
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, size: 50, color: Colors.blue[700]),
                    ),
                    const SizedBox(height: 16),
                    // البطاقة
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  user.username,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // زر التعديل
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text("تعديل البيانات"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<UserCubit>(),
                                child: EditProfilePage(user: user),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
