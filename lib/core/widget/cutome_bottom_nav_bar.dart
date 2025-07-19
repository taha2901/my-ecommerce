import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/cart/ui/cart_page.dart';
import 'package:ecommerce_app/features/favourite/ui/favourite_page.dart';
import 'package:ecommerce_app/features/home/ui/home_page.dart';
import 'package:ecommerce_app/features/profile/ui/profile_page.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const CartPage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: LocaleKeys.home.tr(),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: LocaleKeys.cart.tr(),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart),
        title: LocaleKeys.favorites.tr(),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: LocaleKeys.profile.tr(),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        onItemSelected: (value) {
          setState(() {
            currentIndex = value;
            debugPrint('Current Index is $currentIndex');
          });
        },
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
        backgroundColor: Colors.white,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
      ),
    );
  }
}
