// import 'package:ecommerce_app/features/auth/data/user_data.dart';
// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_cubit.dart';
// import 'package:ecommerce_app/features/profile/logic/user_cubit/user_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// class ProfileAvatar extends StatefulWidget {
//   final UserData? user;
//   final double radius;
//   final bool showEditButton;

//   const ProfileAvatar({super.key, this.user, this.radius = 50, this.showEditButton = false});

//   @override
//   State<ProfileAvatar> createState() => _ProfileAvatarState();
// }

// class _ProfileAvatarState extends State<ProfileAvatar> {
//   String? currentImageUrl;

//   @override
//   void initState() {
//     super.initState();
//     currentImageUrl = widget.user?.imageUrl;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<UserCubit, UserState>(
//       listener: (context, state) {
//         if (state is UserImageUpdated) {
//           setState(() {
//             currentImageUrl = state.imagePath; // تحديث الصورة فوراً
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('تم تحديث الصورة بنجاح'), backgroundColor: Colors.green),
//           );
//         } else if (state is UserLoaded) {
//           setState(() {
//             currentImageUrl = state.user.imageUrl;
//           });
//         }
//       },
//       child: Stack(
//         children: [
//           CircleAvatar(
//             radius: widget.radius,
//             backgroundColor: Colors.grey.shade300,
//             backgroundImage: currentImageUrl != null ? NetworkImage(currentImageUrl!) : null,
//             child: currentImageUrl == null ? Icon(Icons.person, size: widget.radius * 0.8) : null,
//           ),
//           if (widget.showEditButton)
//             Positioned(
//               bottom: 0, right: 0,
//               child: BlocBuilder<UserCubit, UserState>(
//                 builder: (context, state) {
//                   return GestureDetector(
//                     onTap: state is UserImageUpdating ? null : () => _showImageOptions(context),
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: state is UserImageUpdating ? Colors.grey : Colors.blue,
//                         shape: BoxShape.circle,
//                       ),
//                       child: state is UserImageUpdating 
//                           ? SizedBox(
//                               width: 16, height: 16,
//                               child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                             )
//                           : Icon(Icons.camera_alt, color: Colors.white, size: 16),
//                     ),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   void _showImageOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.camera_alt),
//             title: const Text('كاميرا'),
//             onTap: () {
//               Navigator.pop(context);
//               context.read<UserCubit>().updateProfileImage(widget.user!.id, ImageSource.camera);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo_library),
//             title: const Text('معرض'),
//             onTap: () {
//               Navigator.pop(context);
//               context.read<UserCubit>().updateProfileImage(widget.user!.id, ImageSource.gallery);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }