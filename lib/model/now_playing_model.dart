// ignore_for_file: constant_identifier_names

class NowPlaying {
  final NowPlayingDates nowPlayingDates;
  final int page;
  final List<NowPlayingResult> results;
  final int totalPages;
  final int totalResults;

  NowPlaying({
    required this.nowPlayingDates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
        nowPlayingDates: NowPlayingDates.fromJson(json["dates"]),
        page: json["page"],
        results: List<NowPlayingResult>.from(
            json["results"].map((x) => NowPlayingResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": nowPlayingDates.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class NowPlayingDates {
  final DateTime maximum;
  final DateTime minimum;

  NowPlayingDates({
    required this.maximum,
    required this.minimum,
  });

  factory NowPlayingDates.fromJson(Map<String, dynamic> json) =>
      NowPlayingDates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}

class NowPlayingResult {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final OriginalLanguageNowPlaying originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  NowPlayingResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory NowPlayingResult.fromJson(Map<String, dynamic> json) =>
      NowPlayingResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage:
            originalLanguageValuesNowPlaying.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language":
            originalLanguageValuesNowPlaying.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguageNowPlaying { EN, ES, JA, NO }

final originalLanguageValuesNowPlaying = EnumValuesNowPlaying({
  "en": OriginalLanguageNowPlaying.EN,
  "es": OriginalLanguageNowPlaying.ES,
  "ja": OriginalLanguageNowPlaying.JA,
  "no": OriginalLanguageNowPlaying.NO
});

class EnumValuesNowPlaying<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValuesNowPlaying(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
