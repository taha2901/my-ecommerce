
// import 'package:ecommerce_app/core/helper/constants.dart';
// import 'package:ecommerce_app/core/services/firestore_services.dart';
// import 'package:ecommerce_app/core/services/user_services.dart';
// import 'package:ecommerce_app/features/auth/data/user_data.dart';
// import 'package:ecommerce_app/features/auth/logic/admin/admin_states.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AdminCubit extends Cubit<AdminState> {
//   AdminCubit() : super(AdminInitial());
  
//   final _firestoreServices = FirestoreServices.instance;
//   final _userServices = UserServices();

//   // جلب كل المستخدمين (للأدمن فقط)
//   Future<void> fetchAllUsers() async {
//     emit(AdminLoading());
//     try {
//       final users = await _firestoreServices.getCollection<UserData>(
//         path: 'users',
//         builder: (data, id) => UserData.fromMap(data, id),
//       );
//       emit(AdminUsersLoaded(users));
//     } catch (e) {
//       emit(AdminError("Error loading users: $e"));
//     }
//   }

//   // تغيير دور المستخدم
//   Future<void> updateUserRole(String userId, UserRole newRole) async {
//     emit(AdminLoading());
//     try {
//       // جلب بيانات المستخدم الحالية
//       final userData = await _firestoreServices.getDocument<UserData>(
//         path: ApiPaths.users(userId),
//         builder: (data, id) => UserData.fromMap(data, id),
//       );

//       // تحديث الدور
//       final updatedUser = userData.copyWith(role: newRole);
      
//       await _firestoreServices.setData(
//         path: ApiPaths.users(userId),
//         data: updatedUser.toMap(),
//       );

//       emit(AdminUserRoleUpdated());
      
//       // إعادة جلب المستخدمين
//       await fetchAllUsers();
//     } catch (e) {
//       emit(AdminError("Error updating user role: $e"));
//     }
//   }

//   // حذف مستخدم
//   Future<void> deleteUser(String userId) async {
//     emit(AdminLoading());
//     try {
//       await _firestoreServices.deleteData(path: ApiPaths.users(userId));
      
//       // إعادة جلب المستخدمين
//       await fetchAllUsers();
//     } catch (e) {
//       emit(AdminError("Error deleting user: $e"));
//     }
//   }

//   // إضافة منتج جديد (مثال)
//   Future<void> addProduct(Map<String, dynamic> productData) async {
//     emit(AdminLoading());
//     try {
//       final productId = DateTime.now().millisecondsSinceEpoch.toString();
//       await _firestoreServices.setData(
//         path: 'products/$productId',
//         data: {
//           ...productData,
//           'createdAt': DateTime.now().toIso8601String(),
//           'createdBy': FirebaseAuth.instance.currentUser?.uid,
//         },
//       );
      
//       // يمكنك إضافة state للمنتجات هنا
//     } catch (e) {
//       emit(AdminError("Error adding product: $e"));
//     }
//   }

//   // حذف منتج
//   Future<void> deleteProduct(String productId) async {
//     emit(AdminLoading());
//     try {
//       await _firestoreServices.deleteData(path: 'products/$productId');
//       // إعادة جلب المنتجات
//     } catch (e) {
//       emit(AdminError("Error deleting product: $e"));
//     }
//   }
// }

// // 5. Admin Guard - للتحقق من صلاحيات الأدمن
// class AdminGuard {
//   static Future<bool> checkAdminAccess() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) return false;

//       final userData = await FirestoreServices.instance.getDocument<UserData>(
//         path: ApiPaths.users(currentUser.uid),
//         builder: (data, id) => UserData.fromMap(data, id),
//       );

//       return userData.isAdmin || userData.isSuperAdmin;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> checkSuperAdminAccess() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) return false;

//       final userData = await FirestoreServices.instance.getDocument<UserData>(
//         path: ApiPaths.users(currentUser.uid),
//         builder: (data, id) => UserData.fromMap(data, id),
//       );

//       return userData.isSuperAdmin;
//     } catch (e) {
//       return false;
//     }
//   }
// }
