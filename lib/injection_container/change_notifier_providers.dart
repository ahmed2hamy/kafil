import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kafil/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:kafil/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:kafil/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';
import 'package:kafil/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appBlocsProvider(GetIt sl) {
  return [
    BlocProvider(
      create: (_) => sl<SplashCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<LoginCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<RegisterCubit>(),
    ),
    BlocProvider(
      create: (_) => sl<HomeCubit>(),
    ),
  ];
}

List<SingleChildWidget> appChangeNotifiersProvider(GetIt sl) {
  return [
    ChangeNotifierProvider(
      create: (_) => sl<RegisterProvider>(),
    ),
  ];
}

void disposeProviders(GetIt sl) {
  sl<SplashCubit>().close();
  sl<LoginCubit>().close();
  sl<RegisterCubit>().close();
  sl<HomeCubit>().close();

  sl<RegisterProvider>().dispose();
}
