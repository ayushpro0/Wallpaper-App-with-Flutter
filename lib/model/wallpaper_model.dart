class WallpaperModel {

  late String photographer;
  late String photographerUrl;
  late int photographerId;
  late SrcModel src;

  WallpaperModel(
      {
        required this.photographer,
        required this.photographerId,
        required this.photographerUrl,
        required this.src
      }
      );

  factory WallpaperModel.fromMap(Map<String, dynamic> parsedJson) {
    return WallpaperModel(
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"])
    );
  }
}

class SrcModel {
  late String portrait;
  late String original;

  late String small;

  SrcModel({
    required this.portrait,
    required this.original,
    required this.small
  });

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        original: srcJson["original"],
        small: srcJson["small"],
);
  }
}