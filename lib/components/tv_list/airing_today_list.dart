import 'package:go_movie/system_all_library.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiringTodayList extends StatefulWidget {
  const AiringTodayList({super.key});

  @override
  State<AiringTodayList> createState() => _AiringTodayListState();
}

Future<List<AiringTodayResult>> fetchAiringTodayfromAPI() async {
  final url = Uri.parse(Constants.airingToday);
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
    List<AiringTodayResult> airingToday = List.from(json['results']
        .map((resultJson) => AiringTodayResult.fromJson(resultJson)));
    return airingToday;
  } else {
    throw Exception(
        'Failed to fetch now playing movies. Status code: ${response.statusCode}');
  }
}

class _AiringTodayListState extends State<AiringTodayList> {
  late Future<List<AiringTodayResult>> _airingTodayTV;

  @override
  void initState() {
    super.initState();
    _airingTodayTV = fetchAiringTodayfromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AiringTodayResult>>(
      future: _airingTodayTV,
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
          List<AiringTodayResult> airingTodayResult = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Airing Today', style: AppTextStyle.textmedium),
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
                    ...airingTodayResult.map((movie) {
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
