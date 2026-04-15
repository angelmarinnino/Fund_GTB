import '../models/fund_model.dart';

abstract class FondoRepository {
  Future<List<FundModel>> getFunds();
  Future<List<FundModel>> searchFunds(String query);
  Future<List<FundModel>> filterByType(String type);
}

class FondoRepositoryImpl implements FondoRepository {
  @override
  Future<List<FundModel>> getFunds() async {
    // Simulación de datos. En producción, vendrían de Supabase
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      FundModel(
        id: 1,
        name: 'FPV_BTG_PACTUAL_RECAUDADORA',
        description: 'Fondo de Pensiones Voluntarias',
        type: 'FPV',
        minimum: 75000,
        icon: '📊',
        color: '#E3F2FD',
      ),
      FundModel(
        id: 2,
        name: 'FPV_BTG_PACTUAL_ECOPEROL',
        description: 'Fondo de Pensiones Voluntarias',
        type: 'FPV',
        minimum: 125000,
        icon: '🌿',
        color: '#E8F5E9',
      ),
      FundModel(
        id: 3,
        name: 'DEUDAPRIVADA',
        description: 'Fondo de Inversión Colectiva',
        type: 'FIC',
        minimum: 50000,
        icon: '💼',
        color: '#F3E5F5',
      ),
      FundModel(
        id: 4,
        name: 'FDO-ACCIONES',
        description: 'Fondo de Inversión Colectiva',
        type: 'FIC',
        minimum: 250000,
        icon: '📈',
        color: '#FFF3E0',
      ),
      FundModel(
        id: 5,
        name: 'FPV_BTG_PACTUAL_DINAMICA',
        description: 'Fondo de Pensiones Voluntarias',
        type: 'FPV',
        minimum: 100000,
        icon: '📉',
        color: '#E0F2F1',
      ),
    ];
  }

  @override
  Future<List<FundModel>> searchFunds(String query) async {
    final fondos = await getFunds();
    return fondos
        .where(
          (f) =>
              f.name.toLowerCase().contains(query.toLowerCase()) ||
              f.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<List<FundModel>> filterByType(String type) async {
    final fondos = await getFunds();
    if (type == 'Todos los tipos') {
      return fondos;
    }
    return fondos.where((f) => f.type == type).toList();
  }
}
