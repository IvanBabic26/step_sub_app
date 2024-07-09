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

  @HiveField(3)
  final String? id;

  @HiveField(4,defaultValue: false)
  final bool isSelected;

  PaymentPlan({
    required this.name,
    required this.price,
    this.paymentPlanType = PaymentPlanType.monthly,
    this.id,
    this.isSelected = false,
  });

  PaymentPlan copyWith({String? name, int? price, PaymentPlanType? paymentPlanType, String? id, bool? isSelected}) {
    return PaymentPlan(
      name: name ?? this.name,
      price: price ?? this.price,
      paymentPlanType: paymentPlanType ?? this.paymentPlanType,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

@HiveType(typeId: 2)
enum PaymentPlanType {
  @HiveField(0)
  monthly,
  @HiveField(1)
  yearly
}
