import 'package:flutter/material.dart';
import 'package:fondos_app/gui/views/list_funds/widgets/header_widget.dart';
import 'package:fondos_app/gui/widgets/activity_indicator.dart';
import 'package:fondos_app/gui/widgets/dropdown_menu.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Header and card
                      HeaderPageWidget(
                        saldoDisponible: fundsController.formatCurrency(
                          fundsController.saldoDisponible,
                        ),
                      ),
                      // Filtro y buscador
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Contenido principal
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: fundsController.loading,
                builder: (BuildContext _, bool value, Widget? child) {
                  return value ? const ActivityIndicator() : child!;
                },
                child: Column(
                  children: [
                    for (
                      int index = 0;
                      index < fundsController.fundsFilter.length;
                      index++
                    )
                      FundCard(
                        fund: fundsController.fundsFilter[index],
                        onVerDetalles: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Ver detalles: ${fundsController.fundsFilter[index].name}',
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
