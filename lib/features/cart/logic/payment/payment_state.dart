part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
final class AddNewCardLoading extends PaymentState {}

final class AddNewCardSuccess extends PaymentState {}

final class AddNewCardFailure extends PaymentState {
  final String errorMessage;

  AddNewCardFailure(this.errorMessage);
}

final class FetchingPaymentMethods extends PaymentState {}

final class FetchedPaymentMethods extends PaymentState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethods(this.paymentCards);
}

final class FetchPaymentMethodsError extends PaymentState {
  final String errorMessage;

  FetchPaymentMethodsError(this.errorMessage);
}

final class PayemntChosen extends PaymentState {
  final PaymentCardModel chosenPayment;

  PayemntChosen({ required this.chosenPayment});
}


final class ConfirmPaymentLoading extends PaymentState {}

final class ConfirmPaymentSuccess extends PaymentState {}

final class ConfirmPaymentFailure extends PaymentState {
  final String errorMessage;

  ConfirmPaymentFailure(this.errorMessage);
}