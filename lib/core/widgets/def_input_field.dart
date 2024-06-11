import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../utils/app_colors.dart';

class DefaultInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? withPrefix;
  final bool? withSuffix;
  final bool? obsecureText;
  final double? height;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxlines;
  final EdgeInsetsGeometry? margin;
  const DefaultInputField({
    required this.hintText,
    required this.controller,
    this.height,
    this.withPrefix,
    this.withSuffix,
    this.obsecureText,
    this.textInputType,
    this.maxLength,
    this.margin,
    this.maxlines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55,
      margin: margin,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              }
              return null;
            },
            keyboardType: textInputType,
            maxLength: maxLength,
            maxLines: maxlines ?? 1,
            style: const TextStyle(fontSize: 14),
            obscureText:
                obsecureText ?? false ? AuthCubit.get(context).isHidden : false,
            decoration: InputDecoration(
              counterText: '',
              errorStyle: const TextStyle(height: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: hintText,
              prefixIcon: withPrefix ?? false
                  ? CountryCodePicker(
                      initialSelection: 'eg',
                      onChanged: (CountryCode code) {
                        AuthCubit.get(context).setCountryCode(code.dialCode!);
                      },
                      padding: const EdgeInsets.all(0),
                      flagDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  : null,
              suffixIcon: withSuffix ?? false
                  ? IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.eye,
                        color: AppColors.hintColor,
                        size: 20,
                      ),
                      onPressed: () {
                        AuthCubit.get(context).changePasswordVisability();
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
