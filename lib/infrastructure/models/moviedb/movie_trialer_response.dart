
import 'dart:convert';

class MovieTrialerResponse {
    final int id;
    final List<TrailerDb> results;

    MovieTrialerResponse({
        required this.id,
        required this.results,
    });

    factory MovieTrialerResponse.fromRawJson(String str) => MovieTrialerResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieTrialerResponse.fromJson(Map<String, dynamic> json) => MovieTrialerResponse(
        id: json["id"],
        results: List<TrailerDb>.from(json["results"].map((x) => TrailerDb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class TrailerDb {
    final Iso6391? iso6391;
    final Iso31661? iso31661;
    final String name;
    final String key;
    final Site site;
    final int size;
    final String type;
    final bool official;
    final DateTime publishedAt;
    final String id;

    TrailerDb({
        required this.iso6391,
        required this.iso31661,
        required this.name,
        required this.key,
        required this.site,
        required this.size,
        required this.type,
        required this.official,
        required this.publishedAt,
        required this.id,
    });

    factory TrailerDb.fromRawJson(String str) => TrailerDb.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrailerDb.fromJson(Map<String, dynamic> json) => TrailerDb(
        iso6391:  json["iso_639_1"] == null ? null : iso6391Values.map[json["iso_639_1"]],
        iso31661: json["iso_3166_1"] == null ? null : iso31661Values.map[json["iso_3166_1"]],
        name: json["name"],
        key: json["key"],
        site: siteValues.map[json["site"]]!,
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse[iso6391],
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "name": name,
        "key": key,
        "site": siteValues.reverse[site],
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
    };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({
    "US": Iso31661.US
});

enum Iso6391 { EN }

final iso6391Values = EnumValues({
    "en": Iso6391.EN
});

enum Site { YOU_TUBE }

final siteValues = EnumValues({
    "YouTube": Site.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}