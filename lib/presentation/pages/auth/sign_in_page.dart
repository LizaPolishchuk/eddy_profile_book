import 'package:auto_route/auto_route.dart';
import 'package:eddy_profile_book/common/navigation/app_router.dart';
import 'package:eddy_profile_book/common/utils/error_alert.dart';
import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  final VoidCallback onSignedIn;

  const SignInPage({super.key, required this.onSignedIn});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccess || state is SignUpSuccess) {
            widget.onSignedIn();
          } else if (state is AuthFailure) {
            ErrorAlert.showError(context, error: state.error, onPressedCancel: () => _passwordController.clear());
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
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      contentPadding: EdgeInsets.zero,
                    ),
                    validator: (value) {
                      if (value != null && !StringUtils.emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      // Add your email validation logic here
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      contentPadding: EdgeInsets.zero,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                        ? () => _onPressedSignIn(context)
                        : null,
                    child: const Text('Sign In'),
                  ),
                  TextButton(
                    onPressed: () => _onPressedSignUp(context),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
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

  void _onPressedSignUp(BuildContext context) {
    context.router.push(SignUpRoute(email: _emailController.text));
  }

  void _onPressedSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
