import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/widget/my_text_app.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/chat_bot/my_bot.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomHomeHeader extends StatefulWidget {
  const CustomHomeHeader({super.key});

  @override
  State<CustomHomeHeader> createState() => _CustomHomeHeaderState();
}

class _CustomHomeHeaderState extends State<CustomHomeHeader> {
  String? currentImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 35),
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
                title: 'Taha Hamada',
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
    );
  }
}
