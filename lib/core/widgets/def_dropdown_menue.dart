import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultDropDownMenue extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String hint;
  final String? value;
  final Color? color;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final bool? withIcon;
  final Function(Object? value) onChanged;
  const DefaultDropDownMenue({
    required this.items,
    required this.hint,
    this.value,
    this.color,
    this.margin,
    this.withIcon,
    this.iconColor,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 1,
          color: color ?? Colors.grey[600]!,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          if (withIcon ?? false)
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.deepPurple,
                size: 22,
              ),
            ),
          Expanded(
            child: DropdownButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                size: 40,
              ),
              style: TextStyle(
                color: color == null ? Colors.black : Colors.deepPurple,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              iconEnabledColor: iconColor ?? Colors.grey,
              iconDisabledColor: Colors.grey,
              value: value,
              underline: Container(),
              hint: Text(hint),
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              items: items,
              onChanged: onChanged,
              dropdownColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
