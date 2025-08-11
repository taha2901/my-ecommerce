// Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// Third-party packages
import 'package:easy_localization/easy_localization.dart';
// Core
import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/core/widget/spacing.dart';
// Features - Auth
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
// Features - Profile
import 'package:ecommerce_app/features/profile/ui/widget/language_dialouge.dart';
import 'package:ecommerce_app/features/profile/ui/widget/logout_button_widget.dart';
import 'package:ecommerce_app/features/profile/ui/widget/change_password.dart';
import 'package:ecommerce_app/features/profile/ui/widget/setting_item.dart';
// Localization
import 'package:ecommerce_app/gen/locale_keys.g.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHomeHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    verticalSpace(50),
                    SettingItem(
                        color: Colors.black,
                        icon: Iconsax.profile_2user,
                        title: LocaleKeys.edit_profile.tr(),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routers.userProfileRoute);
                        }),
                    verticalSpace(10),
                    SettingItem(
                        color: Colors.black,
                        icon: Iconsax.password_check4,
                        title: LocaleKeys.change_password.tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ChangePasswordPage()),
                          );
                        }),
                    verticalSpace(10),
                    SettingItem(
                        color: Colors.black,
                        icon: Iconsax.notification,
                        title: LocaleKeys.notifications.tr(),
                        onTap: () {}),
                    verticalSpace(10),
                    SettingItem(
                        color: Colors.black,
                        icon: Iconsax.security_safe4,
                        title: LocaleKeys.security_guards.tr(),
                        onTap: () {}),
                    verticalSpace(10),
                    SettingItem(
                      color: Colors.black,
                      icon: Iconsax.language_circle4,
                      title: LocaleKeys.language.tr(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => const LanguageDialog(),
                        );
                      },
                    ),
                    verticalSpace(10),
                    LogoutButtonWidget(cubit: cubit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
