
import 'package:json_annotation/json_annotation.dart';
import 'package:fondos_app/data/models/fund_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    this.id = 0,
    this.fullName = '',
    this.email = '',
    this.balance = 0,
    this.funds = const [],
  });

  final int id;
  final String fullName;
  final String email;
  final int balance;
  final List<FundModel> funds;


  UserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    int? balance,
    List<FundModel>? funds,
  }) =>
      UserModel(
        id: id ?? this.id,
          fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        balance: balance ?? this.balance,
        funds: funds ?? this.funds,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);


  Map<String, dynamic> toJson() => _$UserModelToJson(this);
    
}
