import 'package:json_annotation/json_annotation.dart';

part 'posts_information_model_res.g.dart';

@JsonSerializable()
class GetPostsInformationRes {
  int? userId;
  int? id;
  String? title;
  String? body;

  GetPostsInformationRes({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory GetPostsInformationRes.fromJson(Map<String, dynamic> json) =>
      _$GetPostsInformationResFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsInformationResToJson(this);
}
