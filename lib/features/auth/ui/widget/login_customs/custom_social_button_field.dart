import 'package:ecommerce_app/features/auth/ui/widget/social_button_widget.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String imgUrl;
  final VoidCallback onTap;
  final Color color;
  final Color borderColor;
  final bool isLoading;

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.imgUrl,
    required this.onTap,
    required this.color,
    required this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialButtonWidget(
      text: text,
      imgUrl: imgUrl,
      isLoading: isLoading,
      onTap: onTap,
      color: color,
      borderColor: borderColor,
    );
  }
}
