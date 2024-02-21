import 'package:flutter_test/flutter_test.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

void main() {
  late UserModel userModel;

  setUp(() {
    userModel = const UserModel.empty();
  });

  test("should be a subclass of [User] entity", () {
    expect(userModel, isA<Users>());
  });

  const DataMap tMap = {
    'id': 1,
    'fullName': 'jhon david',
    'phoneNumber': '+212772374621',
    'password': 'mBSPi3HfsODlFN',
  };

  group("copyWith", () {
    test("should return a [UserModel] with different data", () {
      final result = userModel.copyWith(fullName: "jhon");
      expect(result.fullName, equals("jhon"));
    });
  });

  group("fromMap", () {
    test("should return a [UserModel] with the right data", () {
      final result = UserModel.fromMap(tMap);
      expect(
          result,
          equals(const UserModel(
            id: "uid",
            fullName: 'jhon david',
            phoneNumber: '+212772374621',
            password: 'mBSPi3HfsODlFN',
          )));
    });
  });

  group("toMap", () {
    test("should return a [Map] with the right data", () {
      final result = userModel.toMap();
      expect(
          result,
          equals({
            'id': 0,
            'fullName': '_empty.fullName',
            'phoneNumber': '_empty.phoneNumber',
            'password': '_empty.password',
          }));
    });
  });
}
