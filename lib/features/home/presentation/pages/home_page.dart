import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/features/home/presentation/pages/countries_page.dart';
import 'package:kafil/features/home/presentation/pages/profile_page.dart';
import 'package:kafil/features/home/presentation/pages/services_page.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class HomePage extends StatefulWidget {
  final AppDependencies appDependencies;
  final Profile profile;

  const HomePage({
    super.key,
    required this.appDependencies,
    required this.profile,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDestination = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      ProfilePage(
        appDependencies: widget.appDependencies,
        profile: widget.profile,
      ),
      const CountriesPage(),
      const ServicesPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedDestination,
        onDestinationSelected: (index) {
          setState(() {
            _selectedDestination = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Image.asset(kProfileImage),
            label: kWhoAmIString,
          ),
          NavigationDestination(
            icon: Image.asset(kCountriesImage),
            label: kCountriesString,
          ),
          NavigationDestination(
            icon: Image.asset(kServicesImage),
            label: kServicesString,
          ),
        ],
      ),
      body: _pages[_selectedDestination],
    );
  }
}
