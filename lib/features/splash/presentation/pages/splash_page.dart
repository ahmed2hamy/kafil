import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/app_navigator.dart';
import 'package:kafil/core/widgets/dialogs.dart';
import 'package:kafil/features/login/presentation/pages/login_page.dart';
import 'package:kafil/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashCubit>().getAppDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is AppDependenciesLoadedState) {
          AppNavigator.pushReplacement(
            context,
            LoginPage(
              appDependencies: state.appDependencies,
            ),
          );
        } else if (state is SplashErrorState) {
          Dialogs.showMessage(context, message: state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset(kSplashImage)),
      ),
    );
  }
}
