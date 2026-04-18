
import 'package:json_annotation/json_annotation.dart';
import 'package:fondos_app/data/models/transaction_model.dart';

part 'fund_model.g.dart';

enum SubscriptionNotificationMethod {
  @JsonValue('email')
  email,
  @JsonValue('sms')
  sms,
}

@JsonSerializable()
class FundModel {
  const FundModel({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.type = '',
    this.minimum = 0.0,
    this.icon = '',
    this.color = '',
    this.transactions = const [],
    this.notificationMethod,
  });

  final int id;
  final String name;
  final String description;
  final String type;
  final double minimum;
  final String icon;
  final String color;
  final List<TransactionModel> transactions;
  final SubscriptionNotificationMethod? notificationMethod;

  FundModel copyWith({
    int? id,
    String? name,
    String? description,
    String? type,
    double? minimum,
    String? icon,
    String? color,
    List<TransactionModel>? transactions,
    SubscriptionNotificationMethod? notificationMethod,
  }) =>
      FundModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        minimum: minimum ?? this.minimum,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        transactions: transactions ?? this.transactions,
        notificationMethod: notificationMethod ?? this.notificationMethod,
      );

  factory FundModel.fromJson(Map<String, dynamic> json) =>
      _$FundModelFromJson(json);


  Map<String, dynamic> toJson() => _$FundModelToJson(this);
    
}
