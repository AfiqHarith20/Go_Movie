// ignore_for_file: unnecessary_string_interpolations, unnecessary_null_comparison

import 'package:go_movie/system_all_library.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TvDetailPage extends StatelessWidget {
  final TvResult tvResult;

  const TvDetailPage({Key? key, required this.tvResult}) : super(key: key);

  Future<List<ReviewResult>> fetchReview(int seriesId) async {
    final url = Uri.parse("https://api.themoviedb.org/3/tv/$seriesId/reviews");
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
                    'https://image.tmdb.org/t/p/w200${tvResult.posterPath}',
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
                        'First Air Date:',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        tvResult.firstAirDate != null
                            ? '${DateFormat.yMMMMd().format(tvResult.firstAirDate.toLocal())}'
                            : 'N/A', // Replace 'N/A' with your preferred text for null values
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Popularity: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${tvResult.popularity}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Average: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${tvResult.voteAverage}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Count: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${tvResult.voteCount}',
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
            Text(tvResult.originalName, style: AppTextStyle.titleMedium),
            const SizedBox(height: 8),
            // Overview with lightColorScheme.outlineVariant background
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: lightColorScheme.tertiary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                tvResult.overview,
                style: AppTextStyle.textsmall,
              ),
            ),
            buildReviews(tvResult.id),
          ],
        ),
      ),
    );
  }

  // Modify buildReviews to use Review model
  FutureBuilder<List<ReviewResult>> buildReviews(int seriesId) {
    return FutureBuilder<List<ReviewResult>>(
      future: fetchReview(seriesId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          SizedBox(
            height: 2.h,
          );
          return Text(
            'No reviews available.',
            style: AppTextStyle.textmedium,
          );
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
