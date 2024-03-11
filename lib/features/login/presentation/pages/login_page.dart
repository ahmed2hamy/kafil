import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/app_navigator.dart';
import 'package:kafil/core/services/app_validators.dart';
import 'package:kafil/core/widgets/app_loading_widget.dart';
import 'package:kafil/core/widgets/dialogs.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/home/presentation/pages/home_page.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';
import 'package:kafil/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:kafil/features/register/presentation/pages/register_page.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class LoginPage extends StatefulWidget {
  final AppDependencies appDependencies;

  const LoginPage({super.key, required this.appDependencies});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  bool _passwordHidden = true;
  bool _rememberPassword = false;

  @override
  void initState() {
    super.initState();

    context.read<LoginCubit>().autoLogin();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: KafilAppBar.appBar(context, title: kLoginString),
        body: ScrollableFillRemainingWidget(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(kLoginImage),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.loginEmailValidator,
                    decoration: const InputDecoration(
                      labelText: kEmailAddressString,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _passwordHidden,
                    keyboardType: TextInputType.visiblePassword,
                    validator: AppValidators.loginPasswordValidator,
                    decoration: InputDecoration(
                      labelText: kPasswordString,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordHidden = !_passwordHidden;
                          });
                        },
                        icon: Icon(
                          _passwordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberPassword,
                            onChanged: (value) {
                              setState(() {
                                _rememberPassword = value ?? _rememberPassword;
                              });
                            },
                          ),
                          Text(
                            kRememberMeString,
                            style: kDefaultTextStyle,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          kForgotPasswordString,
                          style: kDefaultTextStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginErrorState) {
                        Dialogs.showErrorMessage(
                          context,
                          message: state.errorMessage,
                        );
                      } else if (state is LoggedInState) {
                        AppNavigator.pushAndRemoveAll(
                          context,
                          HomePage(
                            appDependencies: widget.appDependencies,
                            profile: state.profile,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const AppLoadingWidget();
                      }

                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginCubit>().login(
                                  LoginParams(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    rememberMe: _rememberPassword,
                                  ),
                                );
                          }
                        },
                        child: const Text(kLoginString),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kNoAccountString,
                        style: kDefaultTextStyle,
                      ),
                      const SizedBox(width: 4.0),
                      GestureDetector(
                        onTap: () => AppNavigator.push(
                          context,
                          RegisterPage(
                            appDependencies: widget.appDependencies,
                          ),
                        ),
                        child: Text(
                          kRegisterString,
                          style: kPrimaryBoldTextStyle,
                        ),
                      ),
                    ],
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
