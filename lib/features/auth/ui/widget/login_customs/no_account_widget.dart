import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoAccountWidget extends StatelessWidget {
  const NoAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
