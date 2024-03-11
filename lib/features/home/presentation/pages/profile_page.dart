import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/config/user_config.dart';
import 'package:kafil/core/services/app_navigator.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:kafil/features/login/presentation/pages/login_page.dart';
import 'package:kafil/features/register/presentation/widgets/profile_widget.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class ProfilePage extends StatelessWidget {
  final AppDependencies appDependencies;
  final Profile? profile;

  const ProfilePage({
    super.key,
    required this.appDependencies,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KafilAppBar.appBar(
        context,
        title: kWhoAmIString,
        actions: profile == null
            ? null
            : [
                TextButton(
                  onPressed: () => context.read<LoginCubit>().logout(),
                  child: const Text(kLogoutString),
                ),
              ],
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            UserConfig.logOut();
            AppNavigator.pushAndRemoveAll(
              context,
              LoginPage(
                appDependencies: appDependencies,
              ),
            );
          }
        },
        child: ScrollableFillRemainingWidget(
          hasScrollBody: true,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileWidget(
                appDependencies: appDependencies,
                profile: profile,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
