import 'package:go_movie/system_all_library.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobileScaffold: MobileLayout(),
        tabletScaffold: TabletLayout(),
        desktopScaffold: WebLayout(),
      ),
    );
  }
}
