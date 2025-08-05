import 'package:ecommerce_app/core/services/firestore_services.dart';
import 'package:ecommerce_app/core/helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderServices {
  final _firestore = FirestoreServices.instance;

  Future<void> saveOrderLocation({
    required double latitude,
    required double longitude,
    required String address, // ممكن تخليه اختياري لو مش بتجيبه
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final orderId = _firestore.firestore.collection(ApiPaths.orders()).doc().id;

    final data = {
      "order_id": orderId,
      "user_id": userId,
      "created_at": DateTime.now(),
      "location": {
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      },
    };

    await _firestore.setData(
      path: ApiPaths.order(orderId),
      data: data,
    );
  }
}
