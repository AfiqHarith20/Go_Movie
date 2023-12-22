import 'package:go_movie/system_all_library.dart';
import 'dart:async';

class TvPage extends StatefulWidget {
  const TvPage({super.key});

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  bool _loading = true;
  Timer? _timer;

  // Add a method to simulate content loading
  void loadData() {
    setState(() {
      _loading = true; // Set _loading to true before initiating data fetching
    });

    // Simulate an asynchronous operation
    Future.delayed(const Duration(seconds: 2), () {
      // Once the data fetching is complete, set _loading to false
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Call loadData in initState or wherever appropriate in your code
    loadData();
    _timer = Timer.periodic(const Duration(seconds: 200), (Timer timer) {
      print("Timer tick");
    });
  }

  @override
  void dispose() {
    // Cancel the timer in the dispose method
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: Text(
          "TV",
          style: AppTextStyle.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 8,
            ),
            child: Column(
              children: <Widget>[
                Skeletonizer(
                  enabled: _loading,
                  child: const TvGenreList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const AiringTodayList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const OnTheAirList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const PopularTvList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const TopRatedTVList(), // Pass context here
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
