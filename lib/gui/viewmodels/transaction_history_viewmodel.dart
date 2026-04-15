import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';

class TransactionHistoryViewModel extends ChangeNotifier {
  final String fundName;
  final TransactionRepository repository = TransactionRepositoryImpl();

  List<TransactionModel> transactions = [];
  List<TransactionModel> filteredTransactions = [];
  bool isLoading = true;
  String filterType = 'Todos';

  TransactionHistoryViewModel({required this.fundName}) {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    isLoading = true;
    notifyListeners();

    transactions = await repository.obtenerHistorial(fundName);
    filteredTransactions = transactions;
    isLoading = false;
    notifyListeners();
  }

  void filtrarPorTipo(String tipo) {
    filterType = tipo;
    _aplicarFiltro();
  }

  void _aplicarFiltro() {
    if (filterType == 'Todos') {
      filteredTransactions = transactions;
    } else if (filterType == 'Suscripciones') {
      filteredTransactions = transactions
          .where((tx) => tx.type == TransactionType.suscripcion)
          .toList();
    } else {
      filteredTransactions = transactions
          .where((tx) => tx.type == TransactionType.cancelacion)
          .toList();
    }
    notifyListeners();
  }

  String tipoTexto(TransactionType type) {
    return type == TransactionType.suscripcion ? 'Suscripción' : 'Cancelación';
  }

  double totalSuscripciones() {
    return transactions
        .where((tx) => tx.type == TransactionType.suscripcion)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double totalCancelaciones() {
    return transactions
        .where((tx) => tx.type == TransactionType.cancelacion)
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  String formatearMoneda(double monto) {
    return 'COP \$${monto.toStringAsFixed(0)}';
  }
}
