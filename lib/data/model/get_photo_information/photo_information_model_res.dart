import 'package:json_annotation/json_annotation.dart';

part 'photo_information_model_res.g.dart';

@JsonSerializable()
class GetPhotosInformationRes {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  GetPhotosInformationRes({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory GetPhotosInformationRes.fromJson(Map<String, dynamic> json) =>
      _$GetPhotosInformationResFromJson(json);

  Map<String, dynamic> toJson() => _$GetPhotosInformationResToJson(this);
}
