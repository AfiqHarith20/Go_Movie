class TvGenre {
  final int id;
  final String name;

  TvGenre({
    required this.id,
    required this.name,
  });

  factory TvGenre.fromJson(Map<String, dynamic> json) => TvGenre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
