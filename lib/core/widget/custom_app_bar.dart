import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/widget/my_text_app.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/chat_bot/my_bot.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.kGrayColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 30,
              backgroundImage: const NetworkImage(
                'https://media.istockphoto.com/id/1161336374/photo/portrait-of-confident-young-medical-doctor-on-blue-background.jpg?s=612x612&w=0&k=20&c=zaa4MFrk76JzFKvn5AcYpsD8S0ePYYX_5wtuugCD3ig=',
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextApp(
                  title: '${LocaleKeys.good_evening.tr()}👋',
                  color: AppColors.kGrayColor,
                  size: 17,
                ),
                MyTextApp(
                  title: 'Mohammed Rageh',
                  color: AppColors.kBlackColor,
                  size: 20,
                  // fontWeight: FontWeightHelper.regular,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.kGrayColor.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Iconsax.notification,
                  color: AppColors.kGrayColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, Routers.myBot );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EcommerceChatBotScreen(),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.kGrayColor.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    color: AppColors.kGrayColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
