class FavoriteMovieModel {
  FavoriteMovieModel({
    required this.mediaId,
    this.favorite = true,
    this.mediaType = 'movie',
  });
  final String mediaType;
  final int mediaId;
  final bool favorite;

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) =>
      FavoriteMovieModel(
        mediaType: json["media_type"],
        mediaId: json["media_id"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "media_type": mediaType,
        "media_id": mediaId,
        "favorite": favorite,
      };
}
