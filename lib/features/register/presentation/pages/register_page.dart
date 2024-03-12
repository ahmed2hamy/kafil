import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/app_navigator.dart';
import 'package:kafil/core/services/capitalize_extension.dart';
import 'package:kafil/core/widgets/app_loading_widget.dart';
import 'package:kafil/core/widgets/dialogs.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/core/widgets/page_stepper.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/login/presentation/pages/login_page.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';
import 'package:kafil/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';
import 'package:kafil/features/register/presentation/widgets/profile_widget.dart';
import 'package:kafil/features/register/presentation/widgets/register_widget.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class RegisterPage extends StatefulWidget {
  final AppDependencies appDependencies;

  const RegisterPage({super.key, required this.appDependencies});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerWidgetFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _profileWidgetFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final List<String> _pageTitles = [
    kRegisterString,
    kCompleteDataString,
  ];

  late final List<Widget> _registerWidgets;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();

    _registerWidgets = [
      RegisterWidget(
        userTypes: widget.appDependencies.userTypes
                ?.map((e) => e.name?.capitalize() ?? '')
                .toList() ??
            [],
        formKey: _registerWidgetFormKey,
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        emailController: _emailController,
        passwordController: _passwordController,
        passwordConfirmationController: _passwordConfirmationController,
      ),
      ProfileWidget(
        formKey: _profileWidgetFormKey,
        appDependencies: widget.appDependencies,
        profile: null,
        aboutController: _aboutController,
        birthDateController: _birthDateController,
      ),
    ];
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _aboutController.dispose();
    _birthDateController.dispose();

    context.read<RegisterProvider>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KafilAppBar.appBar(context, title: kRegisterString),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            Dialogs.showMessage(context, message: state.errorMessage);
          } else if (state is RegisteredState) {
            Dialogs.showMessage(context, message: kUserRegisteredMessageString);

            Future.delayed(const Duration(seconds: 1)).then(
              (_) => AppNavigator.pushAndRemoveAll(
                context,
                LoginPage(appDependencies: widget.appDependencies),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoadingState) {
            return const AppLoadingWidget();
          } else {
            return ScrollableFillRemainingWidget(
              hasScrollBody: true,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      PageStepper(
                          currentStep: _pageIndex, pageTitles: _pageTitles),
                      const SizedBox(height: 16.0),
                      Expanded(child: _registerWidgets[_pageIndex]),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          _pageIndex == 1
                              ? const SizedBox()
                              : const Expanded(child: SizedBox(width: 1.0)),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_pageIndex == 0) {
                                  if (_registerWidgetFormKey.currentState
                                          ?.validate() ??
                                      false) {
                                    context
                                        .read<RegisterProvider>()
                                        .setFirstName(
                                            _firstNameController.text);
                                    context
                                        .read<RegisterProvider>()
                                        .setLastName(_lastNameController.text);
                                    context
                                        .read<RegisterProvider>()
                                        .setEmail(_emailController.text);
                                    context
                                        .read<RegisterProvider>()
                                        .setPassword(_passwordController.text);
                                    context
                                        .read<RegisterProvider>()
                                        .setPasswordConfirmation(
                                            _passwordConfirmationController
                                                .text);

                                    setState(() {
                                      _pageIndex = 1;
                                    });
                                  }
                                }else if (_pageIndex == 1) {
                                  context
                                      .read<RegisterProvider>()
                                      .setAbout(_aboutController.text);
                                  context
                                      .read<RegisterProvider>()
                                      .setBirthDate(
                                      _birthDateController.text);

                                  log('1');
                                  _submitRegister();
                                }
                              },
                              child: Text(
                                _pageIndex == 1 ? kSubmitString : kNextString,
                                style: kButtonDefaultTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _submitRegister() {
    RegisterRequestBody.toMap(
            widget.appDependencies, context.read<RegisterProvider>())
        .then(
      (requestFormData) =>
          context.read<RegisterCubit>().register(requestFormData),
    );
  }
}
