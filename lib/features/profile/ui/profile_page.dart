import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/login_page.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
import 'package:ecommerce_app/features/profile/ui/widget/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Center(child: Text('Settings')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'General',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.profile_2user,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routers.userProfileRoute);
                  }),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.password_check4,
                  title: 'Change Password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChangePasswordPage()),
                    );
                  }),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.notification,
                  title: 'Notification',
                  onTap: () {}),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.security_safe4,
                  title: 'Security',
                  onTap: () {}),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.language_circle4,
                  title: 'Language',
                  onTap: () {}),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Preferencess',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Iconsax.security,
                  title: 'Legal and Policies',
                  onTap: () {}),
              const SizedBox(height: 10),
              _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {}),
              const SizedBox(height: 10),
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is AuthLogedout || current is AuthLogoutError,
                listener: (context, state) {
                  if (state is AuthLogedout) {
                    // print("Navigating to login screen");
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  } else if (state is AuthLogoutError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                buildWhen: (previous, current) => current is AuthLogingout,
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
                      title: 'Logout',
                      onTap: () async {
                        await cubit.logOut();
                      });
                },
              ),
              const SizedBox(height: 10),
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
        margin: const EdgeInsets.only(bottom: 10),
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
              const SizedBox(width: 10),
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
