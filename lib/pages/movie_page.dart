import 'package:go_movie/system_all_library.dart';
import 'dart:async';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _HomePageState();
}

class _HomePageState extends State<MoviePage> {
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
          "Movie",
          style: AppTextStyle.titleMedium,
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
                  child: const MovieGenreList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const NowPlayingList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const PopularMovieList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const TopRatedMovieList(), // Pass context here
                ),
                Skeletonizer(
                  enabled: _loading,
                  child: const UpComingList(), // Pass context here
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
