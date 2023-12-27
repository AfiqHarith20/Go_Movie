// ignore_for_file: unnecessary_string_interpolations

import 'package:go_movie/system_all_library.dart';
import 'package:intl/intl.dart';

class TrendingDetailPage extends StatelessWidget {
  final TrendingAllResult trendingResult;

  const TrendingDetailPage({Key? key, required this.trendingResult})
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
                    'https://image.tmdb.org/t/p/w200${trendingResult.posterPath}',
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
                        trendingResult.releaseDate != null
                            ? '${DateFormat.yMMMMd().format(trendingResult.releaseDate!.toLocal())}'
                            : 'N/A', // Replace 'N/A' with your preferred text for null values
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Popularity: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${trendingResult.popularity}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Average: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${trendingResult.voteAverage}',
                        style: AppTextStyle.textsmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vote Count: ',
                        style: AppTextStyle.textmedium,
                      ),
                      Text(
                        '${trendingResult.voteCount}',
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
            Text(trendingResult.title.toString(),
                style: AppTextStyle.titleMedium),
            const SizedBox(height: 8),
            // Overview with lightColorScheme.outlineVariant background
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: lightColorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: lightColorScheme.primary,
                  width: 1.w,
                ),
              ),
              child: Text(
                trendingResult.overview,
                style: AppTextStyle.textsmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
