import 'package:flutter/material.dart';

class AppFunctions {
  static void showLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SimpleDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  static void showNetworkErrorDialog(context, {bool? largeFile}) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          children: [
            Center(
              child: Text(
                largeFile ?? false
                    ? 'sorry,\nimage size is too large!'
                    : 'no internet connection!',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
