import '../models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> obtenerHistorial(String fundName);
}

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<List<TransactionModel>> obtenerHistorial(String fundName) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final all = <TransactionModel>[
      TransactionModel(
        id: 1,
        fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
        transactionType: TransactionType.subscription,
        amount: 150000,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Suscripción inicial al fondo',
      ),
      TransactionModel(
        id: 2,
        fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
        transactionType: TransactionType.cancellation,
        amount: 50000,
        date: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Cancelación parcial de inversión',
      ),
      TransactionModel(
        id: 3,
        fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
        transactionType: TransactionType.subscription,
        amount: 100000,
        date: DateTime.now().subtract(const Duration(days: 8)),
        description: 'Aportación mensual programada',
      ),
      TransactionModel(
        id: 4,
        fundName: 'FPV_BTG_PACTUAL_ECOPEROL',
        transactionType: TransactionType.subscription,
        amount: 200000,
        date: DateTime.now().subtract(const Duration(days: 3)),
        description: 'Suscripción a fondo ecológico',
      ),
      TransactionModel(
        id: 5,
        fundName: 'FDO-ACCIONES',
        transactionType: TransactionType.cancellation,
        amount: 120000,
        date: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Cancelación de posición por venta',
      ),
      TransactionModel(
        id: 6,
        fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
        transactionType: TransactionType.cancellation,
        amount: 25000,
        date: DateTime.now().subtract(const Duration(days: 12)),
        description: 'Retiro parcial por emergencia',
      ),
    ];

    return all.where((tx) => tx.fundName == fundName).toList();
  }
}
