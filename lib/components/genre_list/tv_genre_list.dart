import 'package:go_movie/system_all_library.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TvGenreList extends StatelessWidget {
  const TvGenreList({super.key});

  Future<List<TvGenre>> fetchTvGenres() async {
    final url = Uri.parse(Constants.genreTv);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDYxMWVkZWQ0YTBkYTg1YjUxMDY2MWNjN2EzNjE0MSIsInN1YiI6IjY1ODNiZGZlY2E4MzU0NDEwM2Q3NzZlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8u8De19ZTQI0BnXy5ZZb8PGxrs-V7HFn3hGNAhPDODI',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> genresData = json['genres'];
      List<TvGenre> genres =
          genresData.map((genreJson) => TvGenre.fromJson(genreJson)).toList();
      return genres;
    } else {
      throw Exception(
          'Failed to fetch genres. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TvGenre>>(
      future: fetchTvGenres(), // Call your API to fetch genres
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No genres available.');
        } else {
          List<TvGenre> genres = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                genres.length,
                (index) => CustomButtonTv(
                  title: genres[index].name,
                  onPressed: () => navigateTo(genres[index], context),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void navigateTo(TvGenre genre, BuildContext context) {
    // You can handle navigation to a specific genre page here
    print('Navigate to genre: ${genre.name}');
  }
}

class CustomButtonTv extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButtonTv({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
