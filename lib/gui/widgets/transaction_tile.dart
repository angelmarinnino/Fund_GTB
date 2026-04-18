import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isSubscription = transaction.transactionType == TransactionType.subscription;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: isSubscription ? Colors.green[50] : Colors.red[50],
          child: Icon(
            isSubscription ? Icons.trending_up : Icons.trending_down,
            color: isSubscription ? Colors.green[700] : Colors.red[700],
          ),
        ),
        title: Text(
          isSubscription ? 'Suscripción' : 'Cancelación',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSubscription ? Colors.green[800] : Colors.red[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(transaction.description),
            SizedBox(height: 4),
            Text(
              '${transaction.date?.day ?? 0}/${transaction.date?.month ?? 0}/${transaction.date?.year ?? 0}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'COP \$${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSubscription ? Colors.green[800] : Colors.red[800],
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSubscription ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isSubscription ? 'OK' : 'Pendiente',
                style: TextStyle(
                  fontSize: 11,
                  color: isSubscription ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
