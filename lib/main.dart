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

  // Define a specific AppBarTheme
  final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    // titleTextStyle: AppTextStyle.titleLarge.copyWith(
    //   color: lightColorScheme.onPrimary,
    // ),

    // Add other app bar styles as needed
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
        theme: ThemeData.from(colorScheme: lightColorScheme),
        builder: (context, child) {
          return Theme(
            // Use the specific AppBarTheme for the app bar
            data: ThemeData.from(colorScheme: lightColorScheme).copyWith(
              appBarTheme: appBarTheme,
            ),
            child: child!,
          );
        },
      );
    });
  }
}
