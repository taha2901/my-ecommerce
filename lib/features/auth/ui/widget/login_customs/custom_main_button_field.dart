import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;

  const CustomMainButton({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
        text: text,
        isLoading: isLoading,
        onTap: onTap,
      ),
    );
  }
}
