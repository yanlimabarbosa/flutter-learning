import 'package:content_hub/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:content_hub/cubits/authentication_cubit/authentication_state.dart';
import 'package:content_hub/ui/auth_error_message_widget.dart';
import 'package:content_hub/ui/loading_submit_button_widget.dart';
import 'package:content_hub/validations/validate_confirm_password.dart';
import 'package:content_hub/validations/validate_email.dart';
import 'package:content_hub/validations/validate_name.dart';
import 'package:content_hub/validations/validate_password.dart';
import 'package:content_hub/views/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupFormCard extends StatefulWidget {
  const SignupFormCard({super.key});

  @override
  State<SignupFormCard> createState() => _SignupFormCardState();
}

class _SignupFormCardState extends State<SignupFormCard> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    context.read<AuthenticationCubit>().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationLoading;
        final errorMessage = state is AuthenticationFailure
            ? state.message
            : null;

        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: colors.outline),
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: validatePassword,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(hintText: "Confirm Password"),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return validateConfirmPassword(
                      value,
                      _passwordController.text,
                    );
                  },
                ),
                SizedBox(height: 15),
                AuthErrorMessage(message: errorMessage),
                LoadingSubmitButton(
                  label: 'Create Account',
                  isLoading: isLoading,
                  onPressed: _handleSubmit,
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 12,
                      height: 1.45,
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'By continuing, you agree to keep this demo aligned with the future ',
                      ),
                      TextSpan(
                        text: 'Firebase',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'API',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(text: ' flow.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
