import 'package:go_movie/system_all_library.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

Future<List<TrendingAllResult>> fetchTrendingAllfromAPI(
    [String timeWindow = 'day']) async {
  try {
    final url = Uri.parse('${Constants.trendingAll}$timeWindow');
    final http.Response response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDYxMWVkZWQ0YTBkYTg1YjUxMDY2MWNjN2EzNjE0MSIsInN1YiI6IjY1ODNiZGZlY2E4MzU0NDEwM2Q3NzZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8u8De19ZTQI0BnXy5ZZb8PGxrs-V7HFn3hGNAhPDODI',
        'Content-Type': 'application/json',
      },
    );
    print('Request URL: $url');
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      print('API Now Playing Response: $json');
      List<TrendingAllResult> trendingAll = List.from(json['results']
          .map((resultJson) => TrendingAllResult.fromJson(resultJson)));
      // print('Raw date string: ${json["release_date"]}');

      return trendingAll;
    } else {
      throw Exception(
          'Failed to fetch now playing movies. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching trending items: $error');
    throw error; // rethrow the error
  }
}

class _TrendingPageState extends State<TrendingPage> {
  late Future<List<TrendingAllResult>> _trendingAll;
  bool _loading = true;
  Timer? _timer;
  String _selectedTimeWindow = 'day';

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
    _trendingAll = fetchTrendingAllfromAPI(); // Initialize the data fetching
    _timer = Timer.periodic(const Duration(seconds: 200), (Timer timer) {
      print("Timer tick");
      _trendingAll = fetchTrendingAllfromAPI();
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
        title: Row(
          children: [
            Text(
              "Trending",
              style: AppTextStyle.titleMedium,
            ),
            const Spacer(),
            DropdownButton<String>(
              value: _selectedTimeWindow,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    print('Selected time window: $newValue');
                    _selectedTimeWindow = newValue;
                    _trendingAll = fetchTrendingAllfromAPI(newValue);
                  });
                }
              },
              items: <String>['day', 'week'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
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
                // Display the list of trending items in a grid
                FutureBuilder<List<TrendingAllResult>>(
                  future: _trendingAll,
                  builder: (context, snapshot) {
                    print(
                        'Snapshot connection state: ${snapshot.connectionState}');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      print('Error message: ${snapshot.error}');
                      return const Center(
                        child: Text(
                            'Failed to load trending items. Please try again later.'),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('No trending items available.'),
                      );
                    } else {
                      List<TrendingAllResult> trendingAll = snapshot.data!;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing: 8.0, // Spacing between columns
                          mainAxisSpacing: 8.0, // Spacing between rows
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trendingAll.length,
                        itemBuilder: (BuildContext context, int index) {
                          TrendingAllResult movie = trendingAll[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the detail page when an item is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrendingDetailPage(
                                    trendingResult: movie,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.4, // Adjust the width according to your needs
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
