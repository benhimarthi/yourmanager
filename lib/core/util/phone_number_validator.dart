bool isValidPhoneNumber(String phoneNumber) {
  RegExp regex = RegExp(r'^\+?[1-9]\d{1,14}$');
  return regex.hasMatch(phoneNumber);
}
