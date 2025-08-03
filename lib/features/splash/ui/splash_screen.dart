// import 'package:ecommerce_app/features/auth/logic/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ecommerce_app/core/routings/routers.dart';
// import 'package:ecommerce_app/core/utils/app_colors.dart';
// import 'package:iconsax/iconsax.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late AnimationController _backgroundController;
//   late AnimationController _particleController;

//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoRotationAnimation;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;
//   late Animation<double> _backgroundAnimation;
//   late Animation<double> _particleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Hide status bar for full immersion
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     _initializeAnimations();
//     _startAnimationSequence();
//   }

//   void _initializeAnimations() {
//     // Logo animations
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _logoScaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.elasticOut,
//     ));

//     _logoRotationAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
//     ));

//     _logoOpacityAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//     ));

//     // Text animations
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _textFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeInOut,
//     ));

//     _textSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeOutBack,
//     ));

//     // Background animation
//     _backgroundController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );

//     _backgroundAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _backgroundController,
//       curve: Curves.easeInOut,
//     ));

//     // Particle animation
//     _particleController = AnimationController(
//       duration: const Duration(milliseconds: 4000),
//       vsync: this,
//     );

//     _particleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _particleController,
//       curve: Curves.linear,
//     ));
//   }

//   void _startAnimationSequence() async {
//     // Start background animation
//     _backgroundController.forward();

//     // Start particle animation
//     _particleController.repeat();

//     // Wait a bit then start logo animation
//     await Future.delayed(const Duration(milliseconds: 300));
//     _logoController.forward();

//     // Wait then start text animation
//     await Future.delayed(const Duration(milliseconds: 800));
//     _textController.forward();

//     // Navigate to next screen after all animations
//     await Future.delayed(const Duration(milliseconds: 3500));
//     _navigateToNextScreen();
//   }

//   void _navigateToNextScreen() {
//     // Restore status bar
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);

//     // Navigator.of(context).pushReplacementNamed(Routers.loginRoute);

//     final isAuthenticated = context.read<AuthCubit>().state is AuthDone;

//     Navigator.of(context).pushReplacementNamed(
//       isAuthenticated ? Routers.homeRoute : Routers.loginRoute,
//     );
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     _backgroundController.dispose();
//     _particleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: Listenable.merge([
//           _logoController,
//           _textController,
//           _backgroundController,
//           _particleController,
//         ]),
//         builder: (context, child) {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   AppColors.primary
//                       .withOpacity(0.8 + 0.2 * _backgroundAnimation.value),
//                   AppColors.primary.withOpacity(0.9),
//                   AppColors.primary
//                       .withOpacity(0.7 + 0.3 * _backgroundAnimation.value),
//                 ],
//               ),
//             ),
//             child: Stack(
//               children: [
//                 // Animated background particles
//                 ...List.generate(20, (index) => _buildParticle(index)),

//                 // Main content
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Logo section
//                       FadeTransition(
//                         opacity: _logoOpacityAnimation,
//                         child: ScaleTransition(
//                           scale: _logoScaleAnimation,
//                           child: RotationTransition(
//                             turns: _logoRotationAnimation,
//                             child: Container(
//                               width: 140.w,
//                               height: 140.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.2),
//                                     blurRadius: 30,
//                                     offset: const Offset(0, 15),
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.white.withOpacity(0.1),
//                                     blurRadius: 10,
//                                     offset: const Offset(0, -5),
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Iconsax.bag_2,
//                                 size: 70.r,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 40.h),

//                       // App name and tagline
//                       SlideTransition(
//                         position: _textSlideAnimation,
//                         child: FadeTransition(
//                           opacity: _textFadeAnimation,
//                           child: Column(
//                             children: [
//                               Text(
//                                 'ShopEase',
//                                 style: TextStyle(
//                                   fontSize: 36.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   letterSpacing: 2,
//                                   shadows: [
//                                     Shadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       offset: const Offset(0, 2),
//                                       blurRadius: 4,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 8.h),
//                               Text(
//                                 'تسوق بسهولة وراحة',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontWeight: FontWeight.w300,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 60.h),

//                       // Loading indicator
//                       FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               width: 40.w,
//                               height: 40.h,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 3,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white.withOpacity(0.8),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16.h),
//                             Text(
//                               'جاري التحميل...',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: Colors.white.withOpacity(0.7),
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Version info at bottom
//                 Positioned(
//                   bottom: 50.h,
//                   left: 0,
//                   right: 0,
//                   child: FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Column(
//                       children: [
//                         Text(
//                           'النسخة ١.٠.٠',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: Colors.white.withOpacity(0.6),
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                         SizedBox(height: 8.h),
//                         Text(
//                           'Made with ❤️ in Egypt',
//                           style: TextStyle(
//                             fontSize: 11.sp,
//                             color: Colors.white.withOpacity(0.5),
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildParticle(int index) {
//     final random = (index * 0.1) % 1.0;
//     final size = 4.0 + (random * 8.0);
//     final leftPosition = (index * 37.0) % MediaQuery.of(context).size.width;
//     final animationOffset = (index * 0.2) % 1.0;

//     return Positioned(
//       left: leftPosition,
//       top: -20.h +
//           (MediaQuery.of(context).size.height + 40.h) *
//               (((_particleAnimation.value + animationOffset) % 1.0)),
//       child: Opacity(
//         opacity: 0.3 + (random * 0.4),
//         child: Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.white.withOpacity(0.3),
//                 blurRadius: 4,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
