import 'package:ecommerce_app/core/widget/spacing.dart';
import 'package:ecommerce_app/features/auth/ui/widget/animated_text_field.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/another_loging_widget.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/forget_pass_button_widget.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/logo_and_animition_section.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/no_account_widget.dart';
import 'package:ecommerce_app/features/auth/ui/widget/social_button_widget.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/welcom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/widget/login_customs/label_with_text_field.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(40),
                          // Logo Section with Animation
                          LogoAndAnimitionSection(),
                          verticalSpace(32),
                          // Welcome Text
                          WelcomeTextWidget(),
                          verticalSpace(40),
                          // Form Fields
                          AnimatedTextField(
                            delay: 200,
                            child: LabelWithTextField(
                              label: 'البريد الإلكتروني',
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              hintText: 'أدخل بريدك الإلكتروني',
                            ),
                          ),
                          verticalSpace(20),
                          AnimatedTextField(
                            delay: 400,
                            child: LabelWithTextField(
                              label: 'كلمة المرور',
                              controller: passwordController,
                              prefixIcon: Icons.lock_outline,
                              hintText: 'أدخل كلمة المرور',
                              obsecureText: isObscure,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                            ),
                          ),
                          verticalSpace(16),
                          ForgetPasswordButton(),
                          verticalSpace(32),
                          // Login Button
                          BlocConsumer<AuthCubit, AuthState>(
                            bloc: cubit,
                            listenWhen: (previous, current) =>
                                current is AuthDone || current is AuthError,
                            listener: (context, state) {
                              if (state is AuthDone) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(Routers.homeRoute);
                              } else if (state is AuthError) {
                                _showErrorSnackBar(context, state.message);
                              }
                            },
                            buildWhen: (previous, current) =>
                                current is AuthLoading ||
                                current is AuthError ||
                                current is AuthDone,
                            builder: (context, state) {
                              return Container(
                                width: double.infinity,
                                height: 56.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primary.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: MainButton(
                                  text: 'تسجيل الدخول',
                                  isLoading: state is AuthLoading,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await cubit.loginWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          verticalSpace(32),
                          AnotherLogingWidget(),
                          verticalSpace(23),
                          // Social Media Buttons
                          BlocConsumer<AuthCubit, AuthState>(
                            bloc: cubit,
                            listenWhen: (previous, current) =>
                                current is GoogleAuthDone ||
                                current is GoogleAuthError,
                            listener: (context, state) {
                              if (state is GoogleAuthDone) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(Routers.homeRoute);
                              } else if (state is GoogleAuthError) {
                                _showErrorSnackBar(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              return SocialButtonWidget(
                                text: 'تسجيل الدخول بـ Google',
                                imgUrl:
                                    'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                                isLoading: state is GoogleAuthunticated,
                                onTap: () async {
                                  // await cubit.signInWithGoogle();
                                },
                                color: Colors.red.shade50,
                                borderColor: Colors.red.shade100,
                              );
                            },
                          ),
                          verticalSpace(16),
                          SocialButtonWidget(
                            isLoading: false,
                            text: 'تسجيل الدخول بـ Facebook',
                            imgUrl:
                                'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                            onTap: () {},
                            color: Colors.blue.shade50,
                            borderColor: Colors.blue.shade100,
                          ),
                          verticalSpace(32),
                          // Register Link
                          NoAccountWidget(),
                          verticalSpace(24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}
