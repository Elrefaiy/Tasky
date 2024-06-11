import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DefaultErrorWidget extends StatelessWidget {
  final void Function() refresh;
  const DefaultErrorWidget({
    required this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            color: Colors.redAccent.withOpacity(.7),
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text('Unexpected Error!'),
          Text(
            'Please, Retry Again',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: refresh,
              child: const Text('Refresh'),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
