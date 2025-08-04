import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/widget/label_with_text_field.dart';
import 'package:ecommerce_app/features/auth/ui/widget/social_media_button.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
import 'package:iconsax/iconsax.dart';

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
                          SizedBox(height: 40.h),

                          // Logo Section with Animation
                          Center(
                            child: Container(
                              width: 120.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Iconsax.bag_2,
                                size: 60.r,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Welcome Text
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'مرحباً بك في ShopEase!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'سجل دخولك للبدء في التسوق',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.grey,
                                        height: 1.5,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Form Fields
                          _buildAnimatedTextField(
                            child: LabelWithTextField(
                              label: 'البريد الإلكتروني',
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              hintText: 'أدخل بريدك الإلكتروني',
                            ),
                            delay: 200,
                          ),

                          SizedBox(height: 20.h),

                          _buildAnimatedTextField(
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
                            delay: 400,
                          ),

                          SizedBox(height: 16.h),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                              ),
                              child: Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Login Button
                          BlocConsumer<AuthCubit, AuthState>(
                            bloc: cubit,
                            listenWhen: (previous, current) =>
                                current is AuthDone || current is AuthError,
                            listener: (context, state) {
                              // if (state is AuthDone) {
                              //   Navigator.of(context, rootNavigator: true)
                              //       .pushNamed(Routers.homeRoute);
                              // }
                              if (state is AuthDoneWithRole) {
                                if (state.role == 'admin') {
                                  Navigator.of(context).pushReplacementNamed(
                                      Routers.adminDashboardRoute);
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routers.homeRoute);
                                }
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



                          // BlocConsumer<AuthCubit, AuthState>(
                          //   bloc: cubit,
                          //   listenWhen: (previous, current) =>
                          //       current is AuthDoneWithRole ||
                          //       current is AuthError,
                          //   listener: (context, state) {
                          //     if (state is AuthDoneWithRole) {
                          //       // ✅ تحديث التوجيه بناءً على الدور
                          //       if (state.role == 'admin') {
                          //         Navigator.of(context).pushReplacementNamed(
                          //             Routers.adminDashboardRoute);
                          //       } else {
                          //         Navigator.of(context)
                          //             .pushReplacementNamed(Routers.homeRoute);
                          //       }
                          //     } else if (state is AuthError) {
                          //       _showErrorSnackBar(context, state.message);
                          //     }
                          //   },
                          //   buildWhen: (previous, current) =>
                          //       current is AuthLoading ||
                          //       current is AuthError ||
                          //       current
                          //           is AuthDoneWithRole, // ✅ تغيير من AuthDone إلى AuthDoneWithRole
                          //   builder: (context, state) {
                          //     return Container(
                          //       width: double.infinity,
                          //       height: 56.h,
                          //       decoration: BoxDecoration(
                          //         gradient: LinearGradient(
                          //           colors: [
                          //             AppColors.primary,
                          //             AppColors.primary.withOpacity(0.8),
                          //           ],
                          //         ),
                          //         borderRadius: BorderRadius.circular(16.r),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: AppColors.primary.withOpacity(0.3),
                          //             blurRadius: 12,
                          //             offset: const Offset(0, 6),
                          //           ),
                          //         ],
                          //       ),
                          //       child: MainButton(
                          //         text: 'تسجيل الدخول',
                          //         isLoading: state is AuthLoading,
                          //         onTap: () async {
                          //           if (_formKey.currentState!.validate()) {
                          //             await cubit.loginWithEmailAndPassword(
                          //               emailController.text,
                          //               passwordController.text,
                          //             );
                          //           }
                          //         },
                          //       ),
                          //     );
                          //   },
                          // ),

                          SizedBox(height: 32.h),

                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  'أو سجل دخولك باستخدام',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.grey,
                                        fontSize: 14.sp,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

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
                              return _buildSocialButton(
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

                          SizedBox(height: 16.h),

                          _buildSocialButton(
                            text: 'تسجيل الدخول بـ Facebook',
                            imgUrl:
                                'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                            onTap: () {},
                            color: Colors.blue.shade50,
                            borderColor: Colors.blue.shade100,
                          ),

                          SizedBox(height: 32.h),

                          // Register Link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ليس لديك حساب؟ ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(Routers.registerRoute);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                  ),
                                  child: Text(
                                    'سجل الآن',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),
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

  Widget _buildAnimatedTextField({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildSocialButton({
    required String text,
    required String imgUrl,
    required VoidCallback onTap,
    bool isLoading = false,
    required Color color,
    required Color borderColor,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SocialMediaButton(
        isLoading: isLoading,
        text: text,
        imgUrl: imgUrl,
        onTap: onTap,
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
