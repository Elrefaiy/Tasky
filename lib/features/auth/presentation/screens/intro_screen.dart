import 'package:flutter/material.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/def_button.dart';
import '../widgets/auth_image.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const AuthImage(),
            Text(
              AppStrings.introTitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.introContext,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    height: 1.7,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.login,
                );
              },
              lable: 'Let\'s Start',
              withIcon: true,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
