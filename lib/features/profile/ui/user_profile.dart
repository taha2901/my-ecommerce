import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/auth/data/user_data.dart';
import 'package:ecommerce_app/features/profile/logic/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/profile/logic/user_cubit/user_states.dart';
import 'package:ecommerce_app/features/profile/ui/widget/edit_profile_page.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.tr()),
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
                    backgroundColor: AppColors.kPrimaryColor.withOpacity(0.6),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  // BlocBuilder<UserCubit, UserState>(
                  //   builder: (context, state) {
                  //     if (state is UserLoaded) {
                  //       return ProfileAvatar(
                  //           user: state.user, showEditButton: true);
                  //     }
                  //     return const ProfileAvatar();
                  //   },
                  // ),
                  verticalSpace(16),
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
                            const Icon(Icons.person,
                                color: AppColors.kPrimaryColor),
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
                        verticalSpace(12),
                        Row(
                          children: [
                            const Icon(Icons.email,
                                color: AppColors.kPrimaryColor),
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
                  verticalSpace(24),
                  // زر التعديل
                  ModifyButtons(user: user)
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
    );
  }
}

class ModifyButtons extends StatelessWidget {
  const ModifyButtons({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.edit, color: Colors.white),
        label: Text(LocaleKeys.edit_profile.tr(),
            style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
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
    );
  }
}





// import 'package:easy_localization/easy_localization.dart';
// import 'package:ecommerce_app/core/utils/app_colors.dart';
// import 'package:ecommerce_app/core/widget/spacing.dart';
// import 'package:ecommerce_app/features/auth/data/user_data.dart';
// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_cubit.dart';
// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_states.dart';
// import 'package:ecommerce_app/features/profile/ui/widget/edit_profile_page.dart';
// import 'package:ecommerce_app/features/profile/ui/widget/profile_avatar.dart';
// import 'package:ecommerce_app/gen/locale_keys.g.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserProfilePage extends StatelessWidget {
//   const UserProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => UserCubit()..getUserData(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(LocaleKeys.profile.tr()),
//           centerTitle: true,
//         ),
//         body: BlocBuilder<UserCubit, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               final user = state.user;
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // الصورة الشخصية مع إمكانية التعديل
//                     const ProfileAvatar(
//                       radius: 50,
//                       showEditButton: true,
//                     ),
//                     verticalSpace(16),
                    
//                     // بطاقة المعلومات
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.person, color: AppColors.kPrimaryColor),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   user.username,
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           verticalSpace(12),
//                           Row(
//                             children: [
//                               const Icon(Icons.email, color: AppColors.kPrimaryColor),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   user.email,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     verticalSpace(24),
                    
//                     // زر التعديل
//                     ModifyButtons(user: user)
//                   ],
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(
//                 child: Text(
//                   state.message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//         backgroundColor: Colors.grey[100],
//       ),
//     );
//   }
// }

// class ModifyButtons extends StatelessWidget {
//   const ModifyButtons({
//     super.key,
//     required this.user,
//   });

//   final UserData user;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         icon: const Icon(Icons.edit, color: Colors.white),
//         label: Text(LocaleKeys.edit_profile.tr(),
//             style: const TextStyle(color: Colors.white)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.kPrimaryColor,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => BlocProvider.value(
//                 value: context.read<UserCubit>(),
//                 child: EditProfilePage(user: user),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }