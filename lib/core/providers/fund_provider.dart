import 'package:fondos_app/data/models/fund_model.dart';

import 'disposable_provider.dart';

class FundProvider extends DisposableProvider {
  bool _loading = false;
  FundModel _fund = FundModel();

  FundModel get fund => _fund;

  set fund(FundModel fund) {
    _fund = fund;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  @override
  void disposeValues() {
    _loading = false;
    _fund = FundModel();
  }
}
