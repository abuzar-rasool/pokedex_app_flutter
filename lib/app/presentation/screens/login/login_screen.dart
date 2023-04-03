// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/animated_logo.dart';

import 'package:pokedex_app_flutter/app/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/buttons/custom_outlined_button.dart';
import 'package:pokedex_app_flutter/app/presentation/widgets/divider_with_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AnimatedLogo(isAnimating: false, width: 120, height: 120),
                  const SizedBox(height: 48),
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
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          log(_formKey.currentState!.value.toString());
                        }
                      },
                      buttonText: 'Login',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DividerWithText(text: 'OR'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomOutlinedButton(
                      onPressed: () {},
                      buttonText: 'Register',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
