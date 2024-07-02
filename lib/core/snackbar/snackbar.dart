import 'package:flutter/material.dart';
//Snackbar to display errors
void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}
