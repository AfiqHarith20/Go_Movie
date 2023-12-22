import 'package:go_movie/system_all_library.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopRatedTVList extends StatefulWidget {
  const TopRatedTVList({super.key});

  @override
  State<TopRatedTVList> createState() => _TopRatedTVListState();
}

Future<List<TopRatedTvResult>> fetchTopRatedTvfromAPI() async {
  final url = Uri.parse(Constants.topRatedTv);
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
    List<TopRatedTvResult> topRatedTv = List.from(json['results']
        .map((resultJson) => TopRatedTvResult.fromJson(resultJson)));
    return topRatedTv;
  } else {
    throw Exception(
        'Failed to fetch now playing movies. Status code: ${response.statusCode}');
  }
}

class _TopRatedTVListState extends State<TopRatedTVList> {
  late Future<List<TopRatedTvResult>> _topRatedTV;

  @override
  void initState() {
    super.initState();
    _topRatedTV = fetchTopRatedTvfromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TopRatedTvResult>>(
      future: _topRatedTV,
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
          List<TopRatedTvResult> topRatedResult = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Rated', style: AppTextStyle.textmedium),
                    GestureDetector(
                      onTap: () {
                        // Handle the "View All" button press
                      },
                      child: Text(
                        'View All',
                        style: AppTextStyle.textlink,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...topRatedResult.map((movie) {
                      return Container(
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
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
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
