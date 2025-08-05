
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final Color color ;
  const SettingItem(
      {super.key, this.icon, required this.title, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(width: 10.h),
              Text(title, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              title.toLowerCase() != 'logout'
                  ? const Icon(Icons.arrow_forward_ios, size: 16)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
