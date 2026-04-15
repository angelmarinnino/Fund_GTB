enum TransactionType { suscripcion, cancelacion }

class TransactionModel {
  final int id;
  final String fundName;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String description;

  TransactionModel({
    required this.id,
    required this.fundName,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });
}
