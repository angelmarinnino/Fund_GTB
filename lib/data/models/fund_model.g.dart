// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundModel _$FundModelFromJson(Map<String, dynamic> json) => FundModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  type: json['type'] as String? ?? '',
  minimum: (json['minimum'] as num?)?.toDouble() ?? 0.0,
  icon: json['icon'] as String? ?? '',
  color: json['color'] as String? ?? '',
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  notificationMethod: $enumDecodeNullable(
    _$SubscriptionNotificationMethodEnumMap,
    json['notificationMethod'],
  ),
);

Map<String, dynamic> _$FundModelToJson(FundModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': instance.type,
  'minimum': instance.minimum,
  'icon': instance.icon,
  'color': instance.color,
  'transactions': instance.transactions,
  'notificationMethod':
      _$SubscriptionNotificationMethodEnumMap[instance.notificationMethod],
};

const _$SubscriptionNotificationMethodEnumMap = {
  SubscriptionNotificationMethod.email: 'email',
  SubscriptionNotificationMethod.sms: 'sms',
};
