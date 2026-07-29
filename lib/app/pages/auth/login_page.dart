import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/auth/bloc/auth_cubit.dart';
import 'package:taskflow_mobile/app/pages/auth/widgets/auth_text_field.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/core/autoroutes/routes.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.read<AuthCubit>().login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: TodoColors.bodyGradient),
        child: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                context.router.replace(const TodoRoute());
              }
              if (state.status == AuthStatus.error && state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: TodoColors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 40,
                            offset: const Offset(0, 16)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: TodoColors.primaryGradient,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(FontAwesomeIcons.solidCircleCheck,
                                  color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'TaskFlow',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: TodoColors.textDark),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                gradient: TodoColors.primaryGradient,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('PRO',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Sign in to your account',
                            style: TextStyle(fontSize: 14, color: TodoColors.textMuted)),
                        const SizedBox(height: 32),
                        AuthTextField(
                          label: 'Email Address',
                          icon: FontAwesomeIcons.envelope,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 18),
                        AuthTextField(
                          label: 'Password',
                          icon: FontAwesomeIcons.lock,
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          suffixIcon: _obscurePassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          onSuffixTap: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submit(context),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text('Forgot password?',
                                style: TextStyle(
                                    fontSize: 12.5,
                                    color: TodoColors.primary,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(height: 14),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: state.isLoading ? null : () => _submit(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      gradient: TodoColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                            color: TodoColors.primary.withValues(alpha: 0.3),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6)),
                                      ],
                                    ),
                                    child: Center(
                                      child: state.isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                  color: Colors.white, strokeWidth: 2.5),
                                            )
                                          : const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.rightToBracket,
                                                    color: Colors.white, size: 15),
                                                SizedBox(width: 10),
                                                Text('Sign In',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 15)),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                                style: TextStyle(fontSize: 13, color: TodoColors.textMuted)),
                            GestureDetector(
                              onTap: () => context.router.push(const RegisterRoute()),
                              child: const Text('Register',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: TodoColors.primary,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.lock, size: 10, color: TodoColors.textFaint),
                            const SizedBox(width: 6),
                            Text('Your data is secure and encrypted',
                                style: TextStyle(fontSize: 11, color: TodoColors.textFaint)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
