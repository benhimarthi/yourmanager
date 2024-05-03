import 'dart:io';

import 'package:yourmanager/core/util/typedef.dart';

abstract class ReprensentionRepository {
  ResultFuture<String> uplaodImage(File imageFile);
  ResultFuture<String> getImage(String imagePath);
  ResultVoid deleteImage(String imagePath);
}
