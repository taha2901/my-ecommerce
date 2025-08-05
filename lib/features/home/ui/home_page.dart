import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/widget/custom_app_bar.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/logic/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/category_tab_view.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/home_tab_view.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

// في صفحة الهوم
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // إعادة تحميل البيانات عند الرجوع للصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomHomeHeader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 16.0.h),
                  TabBar(
                    controller: _tabController,
                    unselectedLabelColor: AppColors.grey,
                    tabs: [
                      Tab(text: LocaleKeys.home.tr()),
                      Tab(text: LocaleKeys.category.tr()),
                    ],
                  ),
                  SizedBox(height: 24.0.h),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider(
                    create: (context) => HomeCubit()..getHomeData(),
                    child: HomeTabView(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryCubit()..getCategory(),
                    child: CategoryTabView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

