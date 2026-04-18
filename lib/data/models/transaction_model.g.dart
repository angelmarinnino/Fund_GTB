// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(
  Map<String, dynamic> json,
) => TransactionModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  fundName: json['fundName'] as String? ?? '',
  transactionType:
      $enumDecodeNullable(_$TransactionTypeEnumMap, json['transactionType']) ??
      TransactionType.subscription,
  amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fundName': instance.fundName,
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType]!,
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.subscription: 'subscription',
  TransactionType.cancellation: 'cancellation',
};
