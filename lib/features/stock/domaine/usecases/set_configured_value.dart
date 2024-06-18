import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class SetConfiguredValue
    extends UseCaseWithParam<void, SetConfiguredValueParams> {
  final StockRepository _repository;

  SetConfiguredValue(this._repository);

  @override
  ResultFuture<void> call(SetConfiguredValueParams params) {
    return _repository.setConfiguredValue(params.id, params.value);
  }
}

class SetConfiguredValueParams {
  final String id;
  final bool value;
  SetConfiguredValueParams(this.id, this.value);
}
