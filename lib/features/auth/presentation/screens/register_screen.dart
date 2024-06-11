import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/def_button.dart';
import '../../../../core/widgets/def_input_field.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/widgets/def_dropdown_menue.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Image(
                  image: AssetImage(
                    '${AppStrings.assetImage}avatar_hor.png',
                  ),
                  width: double.infinity,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 15),
                DefaultInputField(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Name',
                  controller: cubit.nameController,
                ),
                const SizedBox(height: 15),
                DefaultInputField(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  controller: cubit.registerPhoneController,
                  hintText: '123-456-7890',
                  withPrefix: true,
                  maxLength: 10,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                DefaultInputField(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  controller: cubit.experienceController,
                  hintText: 'Years of Experience',
                  maxLength: 2,
                  textInputType: TextInputType.number,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return DefaultDropDownMenue(
                      items: cubit.levelItems,
                      value: cubit.level,
                      hint: 'Choose Experience Level',
                      onChanged: (value) {
                        cubit.setLevel(value.toString());
                      },
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    );
                  },
                ),
                DefaultInputField(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  controller: cubit.addressController,
                  hintText: 'Address',
                  textInputType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 15),
                DefaultInputField(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  controller: cubit.registerPasswordController,
                  hintText: 'Password',
                  withSuffix: true,
                  obsecureText: true,
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is UserRegisterSuccessState) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home,
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return DefaultButton(
                      onPressed: () {
                        if (cubit.registerFormKey.currentState!.validate()) {
                          cubit.userRegister();
                        }
                      },
                      lable: 'Sign Up',
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have any account?',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.login,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Sign In here',
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
