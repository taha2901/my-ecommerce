import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/widget/cutome_bottom_nav_bar.dart';
import 'package:ecommerce_app/features/address/logic/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/address/ui/choose_location_page.dart';
import 'package:ecommerce_app/features/auth/ui/register_page.dart';
import 'package:ecommerce_app/features/cart/logic/payment/payment_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/add_new_cart_page.dart';
import 'package:ecommerce_app/features/cart/ui/cart_page.dart';
import 'package:ecommerce_app/features/checkout/ui/checkout_page.dart';
import 'package:ecommerce_app/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/home/ui/product_details_page.dart';
import 'package:ecommerce_app/features/profile/ui/widget/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/ui/login_page.dart';

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

      case Routers.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => const CheckoutPage(),
          settings: settings,
        );

      case Routers.chooseLocation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChooseLocationCubit();
              cubit.fetchLocations();
              return cubit;
            },
            child: const ChooseLocationPage(),
          ),
          settings: settings,
        );
      case Routers.addNewCardRoute:
        final paymentCubit = settings.arguments as PaymentCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: paymentCubit,
            child: const AddNewCardPage(),
          ),
          settings: settings,
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
