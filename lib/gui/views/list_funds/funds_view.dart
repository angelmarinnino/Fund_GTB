import 'package:flutter/material.dart';
import 'package:fondos_app/core/providers/user_provider.dart';
import 'package:fondos_app/gui/views/list_funds/widgets/header_widget.dart';
import 'package:fondos_app/gui/widgets/activity_indicator.dart';
import 'package:fondos_app/gui/widgets/dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'funds_viewmodel.dart';
import 'widgets/fund_card.dart';

class FundsView extends StatefulWidget {
  const FundsView({super.key});

  @override
  State<FundsView> createState() => _FundsViewState();
}

class _FundsViewState extends State<FundsView> {
  late final FundServiceController fundsController;

  @override
  void initState() {
    fundsController = FundServiceController(context)..init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, _) {
                      return HeaderPageWidget(
                        availableBalance: fundsController.formatCurrency(
                          userProvider.user.balance.toDouble(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownItem(
                          iconDropColor: Colors.black87,
                          items: fundsController.identificationTypes,
                          initValue: fundsController.selectedFundType,
                          onChanged: (value) =>
                              fundsController.setFundType(value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          onChanged: (value) {
                            fundsController.search(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Buscar fondo...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Contenido principal: loadFunds + estado de suscripción del usuario
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, _) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: fundsController.loading,
                    builder: (BuildContext context, bool loading, __) {
                      if (loading) {
                        return const ActivityIndicator();
                      }
                      final funds = fundsController.fundsFilter;
                      if (funds.isEmpty) {
                        return const Center(
                          child: Text('No hay fondos para mostrar.'),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: funds.length,
                        itemBuilder: (context, index) {
                          final fundCatalog = funds[index];
                          final fund = userProvider.fundForList(fundCatalog);
                          return FundCard(
                            fundsController: fundsController,
                            fund: fund,
                            onVerDetalles: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Ver detalles: ${fundCatalog.name}',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
