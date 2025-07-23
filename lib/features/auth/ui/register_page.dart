import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routings/routers.dart';
import '../../../core/utils/app_colors.dart';
import '../../cart/ui/widget/main_button.dart';
import 'widget/label_with_text_field.dart';
import 'widget/social_media_button.dart';
import 'package:iconsax/iconsax.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool agreeToTerms = false;

  late AnimationController _animationController;
  late AnimationController _bounceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
    _bounceController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bounceController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
                          SizedBox(height: 30.h),

                          // Back Button
                          Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: 20.r,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Header Section with Animation
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Center(
                              child: Container(
                                width: 100.w,
                                height: 100.h,
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
                                  Iconsax.user_add,
                                  size: 50.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Title and Subtitle
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'إنشاء حساب جديد',
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
                                  'أنشئ حسابك الآن واستمتع بتجربة تسوق مميزة',
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

                          SizedBox(height: 32.h),

                          // Form Fields with Staggered Animation
                          _buildAnimatedTextField(
                            child: LabelWithTextField(
                              label: 'اسم المستخدم',
                              controller: usernameController,
                              prefixIcon: Icons.person_outline,
                              hintText: 'أدخل اسم المستخدم',
                            ),
                            delay: 200,
                          ),

                          SizedBox(height: 20.h),

                          _buildAnimatedTextField(
                            child: LabelWithTextField(
                              label: 'البريد الإلكتروني',
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              hintText: 'أدخل بريدك الإلكتروني',
                            ),
                            delay: 400,
                          ),

                          SizedBox(height: 20.h),

                          _buildAnimatedTextField(
                            child: LabelWithTextField(
                              label: 'كلمة المرور',
                              controller: passwordController,
                              prefixIcon: Icons.lock_outline,
                              hintText: 'أدخل كلمة مرور قوية',
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
                            delay: 600,
                          ),

                          SizedBox(height: 20.h),

                          // Password Strength Indicator
                          _buildPasswordStrengthIndicator(),

                          SizedBox(height: 24.h),

                          // Terms and Conditions
                          _buildTermsCheckbox(),

                          SizedBox(height: 32.h),

                          // Register Button
                          BlocConsumer<AuthCubit, AuthState>(
                            bloc: cubit,
                            listenWhen: (previous, current) =>
                                current is AuthDone || current is AuthError,
                            buildWhen: (previous, current) =>
                                current is AuthDone ||
                                current is AuthLoading ||
                                current is AuthError,
                            listener: (context, state) {
                              if (state is AuthDone) {
                                _showSuccessDialog();
                              }
                              if (state is AuthError) {
                                _showErrorSnackBar(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              return Container(
                                width: double.infinity,
                                height: 56.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: agreeToTerms
                                        ? [
                                            AppColors.primary,
                                            AppColors.primary.withOpacity(0.8),
                                          ]
                                        : [
                                            Colors.grey.shade300,
                                            Colors.grey.shade400,
                                          ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: agreeToTerms
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: MainButton(
                                  text: 'إنشاء الحساب',
                                  isLoading: state is AuthLoading,
                                  onTap: agreeToTerms
                                      ? () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await cubit
                                                .registerWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text,
                                              usernameController.text,
                                            );
                                          }
                                        }
                                      : null,
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 24.h),

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
                                  'أو سجل باستخدام',
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

                          SizedBox(height: 20.h),

                          // Social Media Buttons
                          _buildSocialButton(
                            text: 'التسجيل بـ Google',
                            imgUrl:
                                'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                            onTap: () {},
                            color: Colors.red.shade50,
                            borderColor: Colors.red.shade100,
                          ),

                          SizedBox(height: 12.h),

                          _buildSocialButton(
                            text: 'التسجيل بـ Facebook',
                            imgUrl:
                                'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                            onTap: () {},
                            color: Colors.blue.shade50,
                            borderColor: Colors.blue.shade100,
                          ),

                          SizedBox(height: 24.h),

                          // Login Link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'لديك حساب بالفعل؟ ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                  ),
                                  child: Text(
                                    'سجل دخولك',
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

  Widget _buildPasswordStrengthIndicator() {
    String password = passwordController.text;
    int strength = _calculatePasswordStrength(password);
    Color strengthColor = _getStrengthColor(strength);
    String strengthText = _getStrengthText(strength);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'قوة كلمة المرور: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                strengthText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: strengthColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            height: 4.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 3 ? 4.w : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color:
                          index < strength ? strengthColor : Colors.transparent,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: (value) {
            setState(() {
              agreeToTerms = value ?? false;
            });
          },
          activeColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                agreeToTerms = !agreeToTerms;
              });
            },
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
                children: [
                  const TextSpan(text: 'أوافق على '),
                  TextSpan(
                    text: 'الشروط والأحكام',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: ' و '),
                  TextSpan(
                    text: 'سياسة الخصوصية',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

  int _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;

    int strength = 0;

    // Length check
    if (password.length >= 8) strength++;

    // Contains lowercase
    if (password.contains(RegExp(r'[a-z]'))) strength++;

    // Contains uppercase
    if (password.contains(RegExp(r'[A-Z]'))) strength++;

    // Contains numbers or special characters
    if (password.contains(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'))) strength++;

    return strength;
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow.shade700;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'ضعيفة';
      case 2:
        return 'متوسطة';
      case 3:
        return 'جيدة';
      case 4:
        return 'قوية';
      default:
        return 'غير محددة';
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 40.r,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'تم إنشاء الحساب بنجاح!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              'سيتم توجيهك إلى الصفحة الرئيسية',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routers.homeRoute,
        (route) => false,
      );
    });
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
