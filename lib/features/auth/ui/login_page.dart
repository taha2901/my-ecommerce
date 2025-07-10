import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widget/main_button.dart';
import 'package:ecommerce_app/features/auth/ui/widget/label_with_text_field.dart';
import 'package:ecommerce_app/features/auth/ui/widget/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routings/routers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Login Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please, login with registered account!',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Enter you email',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.password,
                    hintText: 'Enter you password',
                    obsecureText: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(Routers.homeRoute);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthError ||
                        current is AuthDone,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(
                          isLoading: true,
                        );
                      }
                      return MainButton(
                        text: 'Login',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.loginWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(Routers.registerRoute);
                          },
                          child: const Text('Don\'t have an account? Register'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Or using other method',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) =>
                              current is GoogleAuthDone ||
                              current is GoogleAuthError,
                          listener: (context, state) {
                            if (state is GoogleAuthDone) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(Routers.homeRoute);
                            }

                            if (state is GoogleAuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is GoogleAuthunticated ||
                              current is GoogleAuthDone ||
                              current is GoogleAuthError,
                          builder: (context, state) {
                            if (state is GoogleAuthunticated) {
                              return SocialMediaButton(
                                isLoading: true,
                              );
                            }
                            return SocialMediaButton(
                              text: 'Login with Google',
                              imgUrl:
                                  'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              onTap: () async {
                                // await cubit.signInWithGoogle();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Login with Facebook',
                          imgUrl:
                              'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
