import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/todos_cubit.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TodosCubit.get(context);
    return TextFormField(
      controller: TodosCubit.get(context).dateController,
      validator: (value) {
        if (value!.isEmpty) {
          return '';
        }
        return null;
      },
      readOnly: true,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        errorStyle: const TextStyle(height: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Choose due date ...',
        suffixIcon: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.solidCalendarDays,
            color: Colors.deepPurple,
            size: 22,
          ),
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2040),
            );
            if (selectedDate != null) {
              cubit.dateController.text =
                  selectedDate.toString().substring(0, 10);
            }
          },
        ),
      ),
    );
  }
}
