import 'package:ecommerce_app/core/routings/app_router.dart';
import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/api_key.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// cart -> checkout -> PaymentMethodsBottomSheet -> CustomButtonBlocConsumer
void main() async {
  // بنعملها عشان نتاكد ان عمل انيشياليز للحاجه قبل م يعمل رن للآب
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKeys.publicKey;
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final authCubit = AuthCubit();
            authCubit.checkAuth();
            return authCubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final favouriteCubit = FavouriteCubit();
            favouriteCubit.getFavoriteProducts();
            return favouriteCubit;
          },
        ),
      ],
      child: Builder(builder: (context) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          buildWhen: (previous, current) =>
              current is AuthDone || current is AuthInitial,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-commerce App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute:
                  state is AuthDone ? Routers.homeRoute : Routers.loginRoute,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        );
      }),
    );
  }
}
