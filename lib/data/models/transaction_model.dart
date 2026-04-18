import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

enum TransactionType { subscription, cancellation }

@JsonSerializable()
class TransactionModel {
  const TransactionModel({
    this.id = 0,
    this.fundName = '',
    this.transactionType = TransactionType.subscription,
    this.amount = 0.0,
    this.date,
    this.description = '',
  });

  final int id;
  final String fundName;
  final TransactionType transactionType;
  final double amount;
  final DateTime? date;
  final String description;

  TransactionModel copyWith({
    int? id,
    String? fundName,
    TransactionType? transactionType,
    double? amount,
    DateTime? date,
    String? description,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        fundName: fundName ?? this.fundName,
        transactionType: transactionType ?? this.transactionType,
        amount: amount ?? this.amount,
        date: date, 
        description: description ?? this.description,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  
}
