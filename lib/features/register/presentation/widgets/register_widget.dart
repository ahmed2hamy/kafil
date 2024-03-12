import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/app_validators.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';

class RegisterWidget extends StatefulWidget {
  final List<String> userTypes;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  const RegisterWidget({
    super.key,
    required this.userTypes,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
  });

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool _passwordHidden = true;
  bool _confirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ScrollableFillRemainingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.firstNameController,
                    validator: AppValidators.fieldRequiredValidator,
                    decoration: const InputDecoration(
                      labelText: kFirstNameString,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.lastNameController,
                    validator: AppValidators.fieldRequiredValidator,
                    decoration: const InputDecoration(
                      labelText: kLastNameString,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: widget.emailController,
              validator: AppValidators.emailValidator,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: kEmailAddressString,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: widget.passwordController,
              validator: AppValidators.passwordValidator,
              obscureText: _passwordHidden,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: kPasswordString,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordHidden = !_passwordHidden;
                    });
                  },
                  icon: Icon(
                    _passwordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: widget.passwordConfirmationController,
              validator: (input) => AppValidators.passwordMatchValidator(
                  input, widget.passwordController.text),
              obscureText: _confirmPasswordHidden,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: kConfirmPasswordString,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _confirmPasswordHidden = !_confirmPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _confirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
