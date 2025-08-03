

import 'package:ecommerce_app/features/auth/data/user_data.dart';

sealed class AdminState {
  const AdminState();
}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminUsersLoaded extends AdminState {
  final List<UserData> users;
  const AdminUsersLoaded(this.users);
}

final class AdminUserRoleUpdated extends AdminState {}

final class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
}

final class AdminProductsLoaded extends AdminState {
  final List<dynamic> products; // حطي نوع المنتج هنا
  const AdminProductsLoaded(this.products);
}