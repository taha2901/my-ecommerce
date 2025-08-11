import 'package:ecommerce_app/core/helper/constants.dart';
import 'package:ecommerce_app/core/services/auth_services.dart';
import 'package:ecommerce_app/core/services/firestore_services.dart';
import 'package:ecommerce_app/features/auth/data/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;

  // Future<void> loginWithEmailAndPassword(String email, String password) async {
  //   emit(AuthLoading());
  //   try {
  //     final result =
  //         await authServices.loginWithEmailAndPassword(email, password);
  //     if (result != null) {
  //       emit(AuthDone());
  //     } else {
  //       emit(AuthError(message: "Invalid email or password"));
  //     }
  //   } catch (e) {
  //     emit(AuthError(message: "Error: $e"));
  //   }
  // }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.loginWithEmailAndPassword(email, password);
      if (user != null) {
        final userData = await firestoreServices.getDocument<UserData>(
          path: ApiPaths.users(user.uid),
          builder: (data, id) => UserData.fromMap(data, id),
        );

        emit(AuthSuccess(userData: userData));
      } else {
        emit(AuthError(message: "Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(message: "Login failed: $e"));
    }
  }

  // Future<void> registerWithEmailAndPassword(
  //     String email, String password, String username) async {
  //   emit(AuthLoading());
  //   try {
  //     final result =
  //         await authServices.registerWithEmailAndPassword(email, password);
  //     if (result) {
  //       await _saveUserData(
  //         email,
  //         username,
  //       );
  //       emit(AuthDone());
  //     } else {
  //       emit(AuthError(message: "Invalid email or password"));
  //     }
  //   } catch (e) {
  //     emit(AuthError(message: "Error: $e"));
  //   }
  // }
  Future<void> registerWithEmailAndPassword(
      String email, String password, String username) async {
    emit(AuthLoading());
    try {
      final user =
          await authServices.registerWithEmailAndPassword(email, password);
      if (user != null) {
        // أنشئ userData بنفسك هنا
        final userData = UserData(
          id: user.uid,
          username: username,
          email: email,
          role: 'user', // ← أي دور افتراضي
          createdAt: DateTime.now().toIso8601String(),
        );

        // خزنه في Firestore
        await firestoreServices.setData(
          path: ApiPaths.users(user.uid),
          // data: userData.toMap(),
          data: userData.copyWith(role: 'user').toMap(),
        );

        // ثم ابعته مع الحالة
        emit(AuthSuccess(userData: userData));
      } else {
        emit(AuthError(message: "Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(message: "Error: $e"));
    }
  }

  Future<void> saveUserData(
      String userId, String email, String username) async {
    final userData = UserData(
      id: userId,
      username: username,
      email: email,
      role: 'user', // 👈 هنا نحدد الدور
      createdAt: DateTime.now().toIso8601String(),
    );

    await firestoreServices.setData(
      path: ApiPaths.users(userData.id),
      data: userData.toMap(),
    );
  }

  // void checkAuth() {
  //   final user = authServices.currentUser();
  //   if (user != null) {
  //     emit(const AuthDone());
  //   }
  // }

    void checkAuth() async {
    emit(AuthChecking()); // حالة جديدة للتحقق الأولي
    final user = authServices.currentUser();
    if (user != null) {
      try {
        final userData = await firestoreServices.getDocument<UserData>(
          path: ApiPaths.users(user.uid),
          builder: (data, id) => UserData.fromMap(data, id),
        );
        emit(AuthSuccess(userData: userData));
      } catch (e) {
        emit(AuthError(message: "Error fetching user data: $e"));
      }
    } else {
      emit(AuthInitial()); // لا يوجد مستخدم مسجل دخول
    }
  }

  Future<void> logOut() async {
    emit(AuthLogingout());
    try {
      await authServices.logOut();
      emit(AuthLogedout());
    } catch (e) {
      emit(AuthLogoutError(message: "Error: $e"));
    }
  }
}
