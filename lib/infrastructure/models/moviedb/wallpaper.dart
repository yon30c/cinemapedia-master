
import 'dart:convert';

class Wallpapers {
    final List<Wallpaper> data;
    final Meta meta;

    Wallpapers({
        required this.data,
        required this.meta,
    });

    factory Wallpapers.fromRawJson(String str) => Wallpapers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wallpapers.fromJson(Map<String, dynamic> json) => Wallpapers(
        data: List<Wallpaper>.from(json["data"].map((x) => Wallpaper.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class Wallpaper {
    final String id;
    final String url;
    final String shortUrl;
    final int views;
    final int favorites;
    final String source;
    final Purity purity;
    final Category category;
    final int dimensionX;
    final int dimensionY;
    final String resolution;
    final String ratio;
    final int fileSize;
    final FileType fileType;
    final DateTime createdAt;
    final List<String> colors;
    final String path;
    final Thumbs thumbs;

    Wallpaper({
        required this.id,
        required this.url,
        required this.shortUrl,
        required this.views,
        required this.favorites,
        required this.source,
        required this.purity,
        required this.category,
        required this.dimensionX,
        required this.dimensionY,
        required this.resolution,
        required this.ratio,
        required this.fileSize,
        required this.fileType,
        required this.createdAt,
        required this.colors,
        required this.path,
        required this.thumbs,
    });

    factory Wallpaper.fromRawJson(String str) => Wallpaper.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
        id: json["id"],
        url: json["url"],
        shortUrl: json["short_url"],
        views: json["views"],
        favorites: json["favorites"],
        source: json["source"],
        purity: purityValues.map[json["purity"]]!,
        category: categoryValues.map[json["category"]]!,
        dimensionX: json["dimension_x"],
        dimensionY: json["dimension_y"],
        resolution: json["resolution"],
        ratio: json["ratio"],
        fileSize: json["file_size"],
        fileType: fileTypeValues.map[json["file_type"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        colors: List<String>.from(json["colors"].map((x) => x)),
        path: json["path"],
        thumbs: Thumbs.fromJson(json["thumbs"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "short_url": shortUrl,
        "views": views,
        "favorites": favorites,
        "source": source,
        "purity": purityValues.reverse[purity],
        "category": categoryValues.reverse[category],
        "dimension_x": dimensionX,
        "dimension_y": dimensionY,
        "resolution": resolution,
        "ratio": ratio,
        "file_size": fileSize,
        "file_type": fileTypeValues.reverse[fileType],
        "created_at": createdAt.toIso8601String(),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "path": path,
        "thumbs": thumbs.toJson(),
    };
}

enum Category { GENERAL, ANIME }

final categoryValues = EnumValues({
    "anime": Category.ANIME,
    "general": Category.GENERAL
});

enum FileType { IMAGE_JPEG, IMAGE_PNG }

final fileTypeValues = EnumValues({
    "image/jpeg": FileType.IMAGE_JPEG,
    "image/png": FileType.IMAGE_PNG
});

enum Purity { SFW }

final purityValues = EnumValues({
    "sfw": Purity.SFW
});

class Thumbs {
    final String large;
    final String original;
    final String small;

    Thumbs({
        required this.large,
        required this.original,
        required this.small,
    });

    factory Thumbs.fromRawJson(String str) => Thumbs.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Thumbs.fromJson(Map<String, dynamic> json) => Thumbs(
        large: json["large"],
        original: json["original"],
        small: json["small"],
    );

    Map<String, dynamic> toJson() => {
        "large": large,
        "original": original,
        "small": small,
    };
}

class Meta {
    final int currentPage;
    final int lastPage;
    final int perPage;
    final int total;
    final dynamic query;
    final dynamic seed;

    Meta({
        required this.currentPage,
        required this.lastPage,
        required this.perPage,
        required this.total,
        this.query,
        this.seed,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
        query: json["query"],
        seed: json["seed"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "query": query,
        "seed": seed,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
