import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/widget/cutome_bottom_nav_bar.dart';
import 'package:ecommerce_app/features/auth/ui/register_page.dart';
import 'package:ecommerce_app/features/cart/ui/cart_page.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/home/ui/product_details_page.dart';
import 'package:ecommerce_app/features/profile/ui/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/ui/login_page.dart';

// checkoutRoute
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routers.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );

      case Routers.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case Routers.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );

      case Routers.productDetailsRoute:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ProductDetailsCubit()..getProductDetails(productId),
            child: ProductDetailsPage(
              productId: productId,
            ),
          ),
          settings: settings,
        );

      case Routers.userProfileRoute:
        return MaterialPageRoute(
          builder: (_) => const UserProfilePage(),
          settings: settings,
        );

      case Routers.editProfileRoute:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );

      case Routers.cartRoute:
        return MaterialPageRoute(
          builder: (_) => CartPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error Page')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
