import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/capitalize_extension.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/core/widgets/page_stepper.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';
import 'package:kafil/features/register/presentation/widgets/profile_widget.dart';
import 'package:kafil/features/register/presentation/widgets/register_widget.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final AppDependencies appDependencies;

  const RegisterPage({super.key, required this.appDependencies});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerWidgetFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

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
        appDependencies: widget.appDependencies,
        profile: null,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KafilAppBar.appBar(context, title: kRegisterString),
      body: ScrollableFillRemainingWidget(
        hasScrollBody: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                PageStepper(currentStep: _pageIndex, pageTitles: _pageTitles),
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
                          if (_registerWidgetFormKey.currentState?.validate() ??
                              false) {
                            context
                                .read<RegisterProvider>()
                                .setFirstName(_firstNameController.text);
                            context
                                .read<RegisterProvider>()
                                .setFirstName(_lastNameController.text);
                            context
                                .read<RegisterProvider>()
                                .setFirstName(_emailController.text);
                            context
                                .read<RegisterProvider>()
                                .setFirstName(_passwordController.text);

                            setState(() {
                              _pageIndex = 1;
                            });
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
      ),
    );
  }
}
