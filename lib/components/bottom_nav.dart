// ignore_for_file: override_on_non_overriding_member

import 'package:go_movie/system_all_library.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = const MoviePage();
  }

  @override
  Widget build(BuildContext context) {
    const ColorScheme colorScheme = lightColorScheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _currentPage,
        bottomNavigationBar: ConvexAppBar(
          items: const [
            TabItem(icon: FontAwesomeIcons.film, title: 'Movie'),
            TabItem(icon: FontAwesomeIcons.tv, title: 'TV'),
            TabItem(icon: FontAwesomeIcons.boltLightning, title: 'Trending'),
            // TabItem(icon: FontAwesomeIcons.user, title: 'Account'),
          ],
          backgroundColor: colorScheme.primaryContainer,
          onTap: _handleNavigationChange,
          style: TabStyle.reactCircle,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _currentPage = const MoviePage();
          break;
        case 1:
          _currentPage = const TvPage();
          break;
      }
      _currentPage = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        child: _currentPage,
      );
    });
  }
}
