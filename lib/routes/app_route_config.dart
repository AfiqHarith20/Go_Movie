import 'package:go_movie/system_all_library.dart';

class PagesLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        "/moviepage",
      ];
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = [
      const BeamPage(
        key: ValueKey('movie'),
        title: "Welcome to Go Movie",
        child: LandingPage(),
      ),
      if (state.uri.pathSegments.isNotEmpty &&
          (state.uri.pathSegments.first == 'welcome' ||
              state.uri.pathSegments.first == 'login' ||
              state.uri.pathSegments.first == 'register' ||
              state.uri.pathSegments.first == 'moviepage' ||
              state.uri.pathSegments.first == 'tvpage' ||
              state.uri.pathSegments.first == 'review' ||
              state.uri.pathSegments.first == 'profile'))
        if (state.uri.pathSegments.contains('homepage'))
          const BeamPage(
            key: ValueKey('moviepage'),
            title: "Movie Page",
            child: MoviePage(),
          ),
      if (state.uri.pathSegments.contains('tv'))
        const BeamPage(
          key: ValueKey('tvpage'),
          title: "Tv Page",
          child: TvPage(),
        ),
    ];
    return pages;
  }
}
