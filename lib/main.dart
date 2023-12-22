import 'package:go_movie/system_all_library.dart';

bool isDebugMode = true;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    // initialPath: '/welcome',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [PagesLocation()],
    ),
    notFoundRedirectNamed: '/error',
  );

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: isDebugMode,
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDelegate),
      );
    });
  }
}
