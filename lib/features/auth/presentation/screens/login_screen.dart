import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/widgets/def_button.dart';
import '../../../../core/widgets/def_input_field.dart';
import '../../../todos/presentation/cubit/todos_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: cubit.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AuthImage(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 20),
              DefaultInputField(
                controller: cubit.loginPhoneController,
                hintText: '123-456-7890',
                textInputType: TextInputType.phone,
                maxLength: 10,
                withPrefix: true,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 20),
              DefaultInputField(
                controller: cubit.loginPasswordController,
                hintText: 'Password',
                withSuffix: true,
                obsecureText: true,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is UserLoginSuccessState) {
                    TodosCubit.get(context).getTodosLists();
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
                      if (cubit.loginFormKey.currentState!.validate()) {
                        cubit.userLogin();
                      }
                    },
                    lable: 'Sign In',
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Didn\'t have any account?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.register,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Sign Up here',
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
    );
  }
}
