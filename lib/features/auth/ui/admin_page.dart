// import 'package:ecommerce_app/core/routings/routers.dart';
// import 'package:ecommerce_app/core/utils/app_colors.dart';
// import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AdminDashboardScreen extends StatelessWidget {
//   const AdminDashboardScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kWhiteColor,
//       appBar: AppBar(
//         title: const Text('لوحة التحكم الإداري'),
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // تسجيل خروج الأدمن
//               context.read<AuthCubit>().logout();
//               Navigator.of(context).pushReplacementNamed(Routers.loginRoute);
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//           children: [
//             _buildDashboardCard(
//               context: context,
//               title: 'إدارة المنتجات',
//               subtitle: 'إضافة وتعديل المنتجات',
//               icon: Icons.inventory,
//               color: Colors.blue,
//               onTap: () {
//                 Navigator.of(context).pushNamed(Routers.adminProductsRoute);
//               },
//             ),
//             _buildDashboardCard(
//               context: context,
//               title: 'إدارة الطلبات',
//               subtitle: 'عرض ومتابعة الطلبات',
//               icon: Icons.shopping_bag,
//               color: Colors.green,
//               onTap: () {
//                 Navigator.of(context).pushNamed(Routers.adminOrdersRoute);
//               },
//             ),
//             _buildDashboardCard(
//               context: context,
//               title: 'إدارة المستخدمين',
//               subtitle: 'عرض بيانات المستخدمين',
//               icon: Icons.people,
//               color: Colors.orange,
//               onTap: () {
//                 Navigator.of(context).pushNamed(Routers.adminUsersRoute);
//               },
//             ),
//             _buildDashboardCard(
//               context: context,
//               title: 'الإحصائيات',
//               subtitle: 'تقارير المبيعات والأرباح',
//               icon: Icons.analytics,
//               color: Colors.purple,
//               onTap: () {
//                 // Navigate to analytics
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard({
//     required BuildContext context,
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 60.w,
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(16.r),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 30.r,
//                   color: color,
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 4.h),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Colors.grey.shade600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }