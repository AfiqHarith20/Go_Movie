import 'package:go_movie/system_all_library.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NowPlayingList extends StatefulWidget {
  const NowPlayingList({Key? key}) : super(key: key);

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

Future<List<MovieResult>> fetchNowPlayingAllfromAPI() async {
  final url = Uri.parse(Constants.nowPlaying);
  final http.Response response = await http.get(
    url,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDYxMWVkZWQ0YTBkYTg1YjUxMDY2MWNjN2EzNjE0MSIsInN1YiI6IjY1ODNiZGZlY2E4MzU0NDEwM2Q3NzZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8u8De19ZTQI0BnXy5ZZb8PGxrs-V7HFn3hGNAhPDODI',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    // print('API Now Playing Response: $json');
    List<MovieResult> nowPlaying = List.from(
        json['results'].map((resultJson) => MovieResult.fromJson(resultJson)));
    return nowPlaying;
  } else {
    throw Exception(
        'Failed to fetch now playing movies. Status code: ${response.statusCode}');
  }
}

class _NowPlayingListState extends State<NowPlayingList> {
  late Future<List<MovieResult>> _nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    _nowPlayingMovies = fetchNowPlayingAllfromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieResult>>(
      future: _nowPlayingMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Failed to load movies. Please try again later.'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No now playing movies available.'),
          );
        } else {
          List<MovieResult> nowPlayingMovies = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Now Playing', style: AppTextStyle.textmedium),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Handle the "View All" button press
                    //   },
                    //   child: Text(
                    //     'View All',
                    //     style: AppTextStyle.textlink,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...nowPlayingMovies.map((movie) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the detail page when the image is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                movieResult: movie,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 30.w,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                  width: 24.w,
                                  height: 18.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
