// ignore_for_file: unnecessary_string_interpolations

import 'package:go_movie/system_all_library.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailPage extends StatelessWidget {
  final MovieResult movieResult;

  const MovieDetailPage({Key? key, required this.movieResult})
      : super(key: key);

  Future<List<ReviewResult>> fetchReview(int movieId) async {
    final url =
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId/reviews");
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
      List<ReviewResult> review = List.from(json['results']
          .map((resultJson) => ReviewResult.fromJson(resultJson)));
      return review;
    } else {
      throw Exception(
          'Failed to fetch now playing movies. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster image and details in a Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show the poster image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w200${movieResult.posterPath}',
                    width: 40.w,
                    height: 30.h, // Set the desired height
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                    width: 16), // Add spacing between poster and details
                // Details column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Release Date:',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${DateFormat.yMMMMd().format(movieResult.releaseDate.toLocal())}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Popularity: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${movieResult.popularity}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Average: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${movieResult.voteAverage}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Count: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${movieResult.voteCount}',
                        style: AppTextStyle.textsmall,
                      ),
                      // Title
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Other details
            Text(movieResult.title, style: AppTextStyle.titleMedium),
            const SizedBox(height: 8),
            // Overview with lightColorScheme.outlineVariant background
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: lightColorScheme.tertiary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                movieResult.overview,
                style: AppTextStyle.textsmall,
              ),
            ),
            buildReviews(movieResult.id),
          ],
        ),
      ),
    );
  }

  // Modify buildReviews to use Review model
  FutureBuilder<List<ReviewResult>> buildReviews(int movieId) {
    return FutureBuilder<List<ReviewResult>>(
      future: fetchReview(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No reviews available.');
        } else {
          List<ReviewResult> reviews = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Reviews',
                style: AppTextStyle.titleMedium,
              ),
              const SizedBox(height: 8),
              // Display reviews using ListView.builder or another suitable widget
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  ReviewResult reviewResult = reviews[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lightColorScheme.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Author: ${reviewResult.author}',
                          style: AppTextStyle.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Content: ${reviewResult.content}',
                          style: AppTextStyle.textsmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${DateFormat.yMMMd().format(reviewResult.updatedAt.toLocal())}',
                          style: AppTextStyle.textsmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
