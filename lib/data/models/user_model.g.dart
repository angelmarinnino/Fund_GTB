// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  fullName: json['fullName'] as String? ?? '',
  email: json['email'] as String? ?? '',
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  funds:
      (json['funds'] as List<dynamic>?)
          ?.map((e) => FundModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'balance': instance.balance,
  'funds': instance.funds,
};
