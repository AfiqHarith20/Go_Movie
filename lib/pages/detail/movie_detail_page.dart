// ignore_for_file: unnecessary_string_interpolations

import 'package:go_movie/system_all_library.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieResult movieResult;

  const MovieDetailPage({Key? key, required this.movieResult})
      : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
