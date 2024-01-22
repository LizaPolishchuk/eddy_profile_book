import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/common/utils/string_utils.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_state.dart';
import 'package:eddy_profile_book/presentation/pages/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Listenable.merge([_emailController, _passwordController]).addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              _showErrorAlert(state.error);
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
      ),
    );
  }

  void _onPressedSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  void _onPressedSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  void _showErrorAlert(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () {
                _passwordController.clear();
                Navigator.pop(context);
              },
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
