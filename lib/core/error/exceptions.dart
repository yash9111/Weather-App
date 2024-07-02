//Custom Exception class to handle all the exceptions created by API.


class APiException implements Exception {
  final String message;

  APiException({required this.message});
   @override
  String toString() => message;
}
