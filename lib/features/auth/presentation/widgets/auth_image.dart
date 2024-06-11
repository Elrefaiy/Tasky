import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Image(
        image: AssetImage('${AppStrings.assetImage}avatar.png'),
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
