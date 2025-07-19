import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/login_page.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
import 'package:ecommerce_app/features/profile/ui/widget/change_password.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

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
                    SizedBox(height: 50.h),
                    _buildSettingItem(
                        icon: Iconsax.profile_2user,
                        title: LocaleKeys.edit_profile.tr(),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routers.userProfileRoute);
                        }),
                    SizedBox(height: 10.h),
                    _buildSettingItem(
                        icon: Iconsax.password_check4,
                        title: LocaleKeys.change_password.tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ChangePasswordPage()),
                          );
                        }),
                    SizedBox(height: 10.h),
                    _buildSettingItem(
                        icon: Iconsax.notification,
                        title: LocaleKeys.notifications.tr(),
                        onTap: () {}),
                    SizedBox(height: 10.h),
                    _buildSettingItem(
                        icon: Iconsax.security_safe4,
                        title: LocaleKeys.security_guards.tr(),
                        onTap: () {}),
                    SizedBox(height: 10.h),
                    _buildSettingItem(
                      icon: Iconsax.language_circle4,
                      title: LocaleKeys.language.tr(),
                      onTap: () async {
                        final currentLocale = Localizations.localeOf(context);
                        Locale? selectedLocale = currentLocale;
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(LocaleKeys.select_language.tr()),
                              content: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile<Locale>(
                                        activeColor: AppColors.primary,
                                        value: const Locale('en'),
                                        groupValue: selectedLocale,
                                        title: Text(
                                          LocaleKeys.language_english.tr(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLocale = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<Locale>(
                                        activeColor: AppColors.primary,
                                        value: const Locale('ar'),
                                        groupValue: selectedLocale,
                                        title: Text(
                                          LocaleKeys.language_arabic.tr(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLocale = value;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    LocaleKeys.cancel.tr(),
                                    style: TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (selectedLocale != null &&
                                        selectedLocale != currentLocale) {
                                      await context.setLocale(selectedLocale!);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    LocaleKeys.ok.tr(),
                                    style: TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listenWhen: (previous, current) =>
                          current is AuthLogedout || current is AuthLogoutError,
                      listener: (context, state) {
                        if (state is AuthLogedout) {
                          // print("Navigating to login screen");
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        } else if (state is AuthLogoutError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AuthLogingout,
                      builder: (context, state) {
                        if (state is AuthLogingout) {
                          return MainButton(
                            isLoading: true,
                            onTap: null,
                          );
                        }
                        return _buildSettingItem(
                            color: Colors.red,
                            icon: Iconsax.logout,
                            title: LocaleKeys.logout.tr(),
                            onTap: () async {
                              await cubit.logOut();
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(width: 10.h),
              Text(title, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              title.toLowerCase() != 'logout'
                  ? const Icon(Icons.arrow_forward_ios, size: 16)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
