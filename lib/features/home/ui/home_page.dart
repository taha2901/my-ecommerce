import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/logic/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/features/home/logic/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/category_tab_view.dart';
import 'package:ecommerce_app/features/home/ui/widget/home/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            TabBar(
              controller: _tabController,
              unselectedLabelColor: AppColors.grey,
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Category'),
              ],
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider(
                    create: (context) => HomeCubit()..getHomeData(),
                    child: HomeTabView(),
                  ),
                  BlocProvider(
                    create: (context) =>  CategoryCubit()..getCategory(),
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
