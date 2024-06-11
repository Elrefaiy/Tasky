import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final void Function() onPressed;
  final String lable;
  final bool? withIcon;
  final EdgeInsetsGeometry? margin;
  const DefaultButton({
    required this.onPressed,
    required this.lable,
    this.withIcon,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.buttonsColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lable,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            if (withIcon ?? false) const SizedBox(width: 10),
            if (withIcon ?? false)
              const FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
