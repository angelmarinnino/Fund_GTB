import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/fund_model.dart';
import '../viewmodels/transaction_history_viewmodel.dart';
import '../widgets/transaction_tile.dart';

class TransactionHistoryView extends StatelessWidget {
  final FundModel fund;

  const TransactionHistoryView({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionHistoryViewModel(fundName: fund.name),
      child: Consumer<TransactionHistoryViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Historial de ${fund.name}'),
              backgroundColor: Colors.deepPurple,
              elevation: 0,
            ),
            backgroundColor: Colors.grey[50],
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resumen de transacciones',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSummaryTile(
                                  'Suscripciones',
                                  viewModel.formatearMoneda(
                                    viewModel.totalSuscripciones(),
                                  ),
                                  Colors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSummaryTile(
                                  'Cancelaciones',
                                  viewModel.formatearMoneda(
                                    viewModel.totalCancelaciones(),
                                  ),
                                  Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildFilterButton(context, viewModel, 'Todos'),
                                _buildFilterButton(
                                  context,
                                  viewModel,
                                  'Suscripciones',
                                ),
                                _buildFilterButton(
                                  context,
                                  viewModel,
                                  'Cancelaciones',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: viewModel.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : viewModel.filteredTransactions.isEmpty
                          ? const Center(
                              child: Text(
                                'No hay transacciones para este fondo.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: viewModel.filteredTransactions.length,
                              itemBuilder: (context, index) {
                                return TransactionTile(
                                  transaction:
                                      viewModel.filteredTransactions[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryTile(String title, String amount, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    TransactionHistoryViewModel viewModel,
    String type,
  ) {
    final selected = viewModel.filterType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          viewModel.filtrarPorTipo(type);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.deepPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
