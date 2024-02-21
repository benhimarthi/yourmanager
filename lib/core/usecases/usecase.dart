import 'package:yourmanager/core/util/typedef.dart';

abstract class UseCaseWithParam<Type, Param> {
  const UseCaseWithParam();
  ResultFuture<Type> call(Param params);
}

abstract class UseCaseWithoutParam<Type> {
  const UseCaseWithoutParam();
  ResultFuture<Type> call();
}
