import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_client/core/extension.dart';
import 'package:news_client/core/services/di.dart';
import 'package:news_client/data/auth/register/cubit/register_cubit.dart';
import 'package:news_client/data/auth/register/request.dart';
import 'package:news_client/presentation/dialogs/error.dart';

import '../../../../data/get_news/cubit/get_news_cubit.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  static Future<bool?> show(
    BuildContext context, {
    void Function()? onYes,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => RegisterCubit(getIt()),
        child: const RegisterDialog(),
      ),
    );
  }

  @override
  State<RegisterDialog> createState() => RegisterDialogState();
}

class RegisterDialogState extends State<RegisterDialog> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool enableButton = false;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: const Color(0xffb8191f),
      surfaceTintColor: const Color(0xffb8191f),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 500,
            height: 501,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Mews",
                            style: context.style.titleLarge
                                ?.copyWith(fontSize: 32, color: Colors.white)),
                        const SizedBox(width: 10),
                        const Icon(Icons.flutter_dash, size: 32)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 40),
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style:
                              context.style.bodyLarge?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _usernameController,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: _getInputDecoration('UserName'),
                          onChanged: (_) => _enableLoginButton(),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          decoration: _getInputDecoration('E-mail'),
                          onChanged: (_) => _enableLoginButton(),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          obscureText: true,
                          decoration: _getInputDecoration('Password'),
                          onChanged: (_) => _enableLoginButton(),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _confirmPasswordController,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          obscureText: true,
                          decoration: _getInputDecoration('Confirm Password'),
                          onChanged: (_) => _enableLoginButton(),
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              context.read<GetNewsCubit>().get();
                              Navigator.pop(context);
                            }
                            if (state is RegisterFailure) {
                              showErrorDialog(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            return Center(
                              child: state is RegisterLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed:
                                          enableButton ? _onSubmit : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        disabledBackgroundColor: Colors.grey,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'Register',
                                          style: context.style.bodyLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    final request = RegisterRequest(
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirmation: _passwordController.text,
      username: _usernameController.text,
    );
    context.read<RegisterCubit>().register(request);
  }

  void _enableLoginButton() {
    if (enableButton &&
        (_usernameController.text.trim().isEmpty ||
            _emailController.text.trim().isEmpty ||
            _passwordController.text.trim().isEmpty ||
            _confirmPasswordController.text.trim().isEmpty)) {
      setState(() {
        enableButton = false;
      });
    } else if (!enableButton &&
        _usernameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _confirmPasswordController.text.trim().isNotEmpty) {
      setState(() {
        enableButton = true;
      });
    }
  }

  InputDecoration _getInputDecoration(String hints) {
    return InputDecoration(
      fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
      filled: true,
      border: const OutlineInputBorder(),
      label: Text(
        hints,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
