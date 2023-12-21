import 'package:go_movie/system_all_library.dart';

class PagesLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        "/homepage",
      ];
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('home'),
        title: "Welcome to Merchant Apps",
        child: HomePage(),
      ),
      if (state.uri.pathSegments.isNotEmpty &&
          (state.uri.pathSegments.first == 'welcome' ||
              state.uri.pathSegments.first == 'login' ||
              state.uri.pathSegments.first == 'register' ||
              state.uri.pathSegments.first == 'homepage' ||
              state.uri.pathSegments.first == 'message' ||
              state.uri.pathSegments.first == 'review' ||
              state.uri.pathSegments.first == 'profile'))
        if (state.uri.pathSegments.contains('homepage'))
          const BeamPage(
            key: ValueKey('homepage'),
            title: "Home Page",
            child: HomePage(),
          ),
    ];
    return pages;
  }
}
