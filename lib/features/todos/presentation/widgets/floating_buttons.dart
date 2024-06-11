import 'package:flutter/material.dart';
import '../../../../config/app_routes.dart';

import '../../../../core/utils/app_colors.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 1,
          backgroundColor: const Color(0xFFEBE5FF),
          mini: true,
          shape: const CircleBorder(),
          elevation: 0,
          onPressed: () {
            Navigator.pushNamed(context, Routes.qrScanner);
          },
          child: const Icon(
            Icons.qr_code_rounded,
            color: Colors.deepPurple,
            size: 24,
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 2,
          backgroundColor: AppColors.buttonsColor,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.addTask,
            );
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}
