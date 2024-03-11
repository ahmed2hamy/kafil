import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/widgets/app_loading_widget.dart';
import 'package:kafil/core/widgets/dialogs.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/presentation/manager/home_cubit/home_cubit.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KafilAppBar.appBar(context, title: kServicesString),
      body: ScrollableFillRemainingWidget(
        hasScrollBody: true,
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              Dialogs.showErrorMessage(context, message: state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const AppLoadingWidget();
            } else if (state is ServicesLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServicesListWidget(
                      services: state.servicesMap[kServicesString]),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16.0),
                    child: Text(
                      kPopularServicesString,
                      style: kTitleTextStyle,
                    ),
                  ),
                  ServicesListWidget(
                      services: state.servicesMap[kPopularServicesString]),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class ServicesListWidget extends StatelessWidget {
  const ServicesListWidget({
    super.key,
    required this.services,
  });

  final Services? services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: services?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            width: 200.0,
            margin: const EdgeInsetsDirectional.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: kNeroBoxShadowColor.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 50.0,
                  spreadRadius: -5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    services?.data?[index].mainImage ?? '',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress?.cumulativeBytesLoaded ==
                          loadingProgress?.expectedTotalBytes) {
                        return child;
                      }
                      return const Expanded(child: AppLoadingWidget());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        kProductImage,
                        fit: BoxFit.fitWidth,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        services?.data?[index].title ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: kLabelTextStyle,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(kStarImage),
                          const SizedBox(width: 2.0),
                          Text(
                            '(${services?.data?[index].averageRating})',
                            style: kRatingTextStyle,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            '|',
                            style: kGreyTextStyle,
                          ),
                          const SizedBox(width: 6.0),
                          Image.asset(kBasketImage),
                          const SizedBox(width: 2.0),
                          Text(
                            '${services?.data?[index].price}',
                            style: kGreyTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
