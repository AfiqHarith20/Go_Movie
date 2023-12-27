// ignore_for_file: constant_identifier_names

class TrendingAll {
  final int page;
  final List<TrendingAllResult> results;
  final int totalPages;
  final int totalResults;

  TrendingAll({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingAll.fromJson(Map<String, dynamic> json) => TrendingAll(
        page: json["page"],
        results: List<TrendingAllResult>.from(
            json["results"].map((x) => TrendingAllResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TrendingAllResult {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final OriginalLanguageTrendingAll originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final MediaTypeTrendingAll mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String name;
  final String originalName;
  final String firstAirDate;
  final List<String> originCountry;

  TrendingAllResult({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.name,
    required this.originalName,
    required this.firstAirDate,
    required this.originCountry,
  });

  factory TrendingAllResult.fromJson(Map<String, dynamic> json) =>
      TrendingAllResult(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"] ?? "", // Provide a default value or handle null
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"] ??
            "", // Provide a default value or handle null
        overview:
            json["overview"] ?? "", // Provide a default value or handle null
        posterPath:
            json["poster_path"] ?? "", // Provide a default value or handle null
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble() ??
            0.0, // Provide a default value or handle null
        releaseDate: json["release_date"] == null
            ? DateTime.now() // Provide a default value or handle null
            : DateTime.parse(json["release_date"]),
        video: json["video"] ?? false, // Provide a default value or handle null
        voteAverage: json["vote_average"]?.toDouble() ??
            0.0, // Provide a default value or handle null
        voteCount:
            json["vote_count"] ?? 0, // Provide a default value or handle null
        name: json["name"] ?? "", // Provide a default value or handle null
        originalName: json["original_name"] ??
            "", // Provide a default value or handle null
        firstAirDate: json["first_air_date"] ??
            "", // Provide a default value or handle null
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate,
        "origin_country": originCountry,
      };
}

enum MediaTypeTrendingAll { MOVIE, TV }

final mediaTypeValues = EnumValuesTrendingAll(
    {"movie": MediaTypeTrendingAll.MOVIE, "tv": MediaTypeTrendingAll.TV});

enum OriginalLanguageTrendingAll { EN, KO, PT }

final originalLanguageValues = EnumValuesTrendingAll({
  "en": OriginalLanguageTrendingAll.EN,
  "ko": OriginalLanguageTrendingAll.KO,
  "pt": OriginalLanguageTrendingAll.PT
});

class EnumValuesTrendingAll<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValuesTrendingAll(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
