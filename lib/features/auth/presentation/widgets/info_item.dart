import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/auth_cubit.dart';

class ProfileInfoItem extends StatelessWidget {
  final int index;
  final List<String> info;
  const ProfileInfoItem({
    required this.index,
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthCubit.get(context).profileData[index],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                info[index],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (index == 1)
            IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: info[1]),
                ).then(
                  (value) => showToast(
                    "Coppied to Clipboard",
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    context: context,
                    duration: const Duration(seconds: 3),
                    animation: StyledToastAnimation.fade,
                    reverseAnimation: StyledToastAnimation.fade,
                  ),
                );
              },
              icon: const Icon(
                Icons.copy_rounded,
                color: Colors.deepPurple,
              ),
            )
        ],
      ),
    );
  }
}
