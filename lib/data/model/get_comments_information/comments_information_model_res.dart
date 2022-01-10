import 'package:json_annotation/json_annotation.dart';

part 'comments_information_model_res.g.dart';

@JsonSerializable()
class GetCommentsInformationRes {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  GetCommentsInformationRes({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory GetCommentsInformationRes.fromJson(Map<String, dynamic> json) =>
      _$GetCommentsInformationResFromJson(json);

  Map<String, dynamic> toJson() => _$GetCommentsInformationResToJson(this);
}
