import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final void Function() acceptFunc;
  const PopupDialog({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.acceptFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(25),
      children: [
        const SizedBox(height: 15),
        Text(
          title,
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: acceptFunc,
              child: Text(buttonText),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
