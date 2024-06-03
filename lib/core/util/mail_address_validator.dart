bool isValidEmail(String email) {
  String pattern = r'^[A-Za-z0-9.%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
