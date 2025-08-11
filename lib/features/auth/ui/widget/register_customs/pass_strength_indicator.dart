import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordStrengthIndicator({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    String password = passwordController.text;
    double strength = _calculatePasswordStrength(password);
    Color strengthColor = _getStrengthColor(strength);
    String strengthText = _getStrengthText(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          color: strengthColor,
          backgroundColor: Colors.grey.shade300,
          minHeight: 6.h,
          borderRadius: BorderRadius.circular(8.r),
        ),
        SizedBox(height: 8.h),
        Text(
          strengthText,
          style: TextStyle(
            color: strengthColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

double _calculatePasswordStrength(String password) {
  if (password.isEmpty) return 0.0;
  double strength = 0.0;
  if (password.length >= 6) strength += 0.3;
  if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
  if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.2;
  if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength += 0.3;
  return strength.clamp(0.0, 1.0);
}

Color _getStrengthColor(double strength) {
  if (strength < 0.3) return Colors.red;
  if (strength < 0.7) return Colors.orange;
  return Colors.green;
}

String _getStrengthText(double strength) {
  if (strength < 0.3) return "ضعيفة";
  if (strength < 0.7) return "متوسطة";
  return "قوية";
}

class TermsCheckbox extends StatelessWidget {
  final bool agreeToTerms;
  final ValueChanged<bool> onChanged;

  const TermsCheckbox({
    super.key,
    required this.agreeToTerms,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreeToTerms,
          activeColor: Colors.blue,
          onChanged: (value) => onChanged(value ?? false),
        ),
        Expanded(
          child: Text(
            "أوافق على الشروط والأحكام",
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
