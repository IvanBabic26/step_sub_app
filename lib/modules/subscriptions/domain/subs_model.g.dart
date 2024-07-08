// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      emailAddress: fields[2] as String?,
      phoneNumber: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.emailAddress)
      ..writeByte(3)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentPlanAdapter extends TypeAdapter<PaymentPlan> {
  @override
  final int typeId = 1;

  @override
  PaymentPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentPlan(
      name: fields[0] as String?,
      price: fields[1] as int?,
      paymentPlanType: fields[2] as PaymentPlanType,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentPlan obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.paymentPlanType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentPlanTypeAdapter extends TypeAdapter<PaymentPlanType> {
  @override
  final int typeId = 2;

  @override
  PaymentPlanType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentPlanType.monthly;
      case 1:
        return PaymentPlanType.yearly;
      default:
        return PaymentPlanType.monthly;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentPlanType obj) {
    switch (obj) {
      case PaymentPlanType.monthly:
        writer.writeByte(0);
        break;
      case PaymentPlanType.yearly:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentPlanTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
