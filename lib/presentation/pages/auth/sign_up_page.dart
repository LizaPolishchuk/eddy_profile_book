import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Listenable.merge([_emailController, _passwordController, _confirmPasswordController]).addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is SignUpSuccess) {
              print("SignUpSuccess");
              Navigator.of(context).pop();
            }
            if (state is AuthFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(state.error),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (!StringUtils.emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        } else if (value.length < 8 || value.length > 16) {
                          return 'Email must be between 8 and 16 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                        contentPadding: EdgeInsets.zero,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 4 || value.length > 16) {
                          return 'Password must be between 4 and 16 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Confirm Password',
                        contentPadding: EdgeInsets.zero,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty)
                          ? () => _onPressedSignUp(context)
                          : null,
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onPressedSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
