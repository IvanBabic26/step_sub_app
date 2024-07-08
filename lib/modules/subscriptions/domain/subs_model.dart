import 'package:hive/hive.dart';

part 'subs_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String? firstName;

  @HiveField(1)
  final String? lastName;

  @HiveField(2)
  final String? emailAddress;

  @HiveField(3)
  final String? phoneNumber;

  User({this.firstName, this.lastName, this.emailAddress, this.phoneNumber});

  User copyWith({String? firstName, String? lastName, String? emailAddress, String? phoneNumber}) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

@HiveType(typeId: 1)
class PaymentPlan extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final int? price;

  @HiveField(2)
  final PaymentPlanType paymentPlanType;

  PaymentPlan({required this.name, required this.price, this.paymentPlanType = PaymentPlanType.monthly});

  PaymentPlan copyWith({String? name,int? price, PaymentPlanType? paymentPlanType}) {
    return PaymentPlan(name: name ?? this.name,price: price ?? this.price, paymentPlanType: paymentPlanType ?? this.paymentPlanType);
  }
}

@HiveType(typeId: 2)
enum PaymentPlanType {
  @HiveField(0)
  monthly,
  @HiveField(1)
  yearly
}
