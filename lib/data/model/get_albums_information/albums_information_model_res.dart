import 'package:json_annotation/json_annotation.dart';

part 'albums_information_model_res.g.dart';

@JsonSerializable()
class GetAlbumsInformationRes {
  int? userId;
  int? id;
  String? title;

  GetAlbumsInformationRes({
    this.userId,
    this.id,
    this.title,
  });

  factory GetAlbumsInformationRes.fromJson(Map<String, dynamic> json) =>
      _$GetAlbumsInformationResFromJson(json);

  Map<String, dynamic> toJson() => _$GetAlbumsInformationResToJson(this);
}
