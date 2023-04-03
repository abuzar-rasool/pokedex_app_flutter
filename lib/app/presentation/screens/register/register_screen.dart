import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokedex_app_flutter/app/cubits/register/register_cubit.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/auth_screen_wrapper.dart';

import 'package:pokedex_app_flutter/app/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/buttons/custom_outlined_button.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/divider_with_text.dart';
import 'package:pokedex_app_flutter/core/app_navigator/app_navigator.dart';
import 'package:pokedex_app_flutter/services/snackbar_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            context.read<SnackBarService>().showGenericErrorSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return AuthScreenWrapper(
            isAuthenticating: state is RegisterLoading,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    name: 'password',
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    name: 'confirm_password',
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          String email = _formKey.currentState!.value['email'];
                          String password = _formKey.currentState!.value['password'];
                          String confirmPassword = _formKey.currentState!.value['confirm_password'];
                          if (password == confirmPassword) {
                            context.read<RegisterCubit>().register(email, password);
                          } else {
                            _formKey.currentState!.invalidateField(name: 'confirm_password', errorText: 'Passwords do not match');
                          }
                        }
                      },
                      buttonText: 'Register',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DividerWithText(text: 'OR'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomOutlinedButton(
                      onPressed: () => AppNavigator.replaceWith(Routes.login),
                      buttonText: 'Login',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
