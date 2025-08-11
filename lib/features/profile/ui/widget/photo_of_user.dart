
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PhotoOfUser extends StatelessWidget {
  const PhotoOfUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.kPrimaryColor.withOpacity(0.6),
      child: Icon(Icons.person, size: 50, color: Colors.white),
    );
  }
}
