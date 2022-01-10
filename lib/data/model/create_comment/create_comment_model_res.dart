import 'package:json_annotation/json_annotation.dart';

part 'create_comment_model_res.g.dart';

@JsonSerializable()
class CreateCommentRes {
  int id;
  String name;
  String email;
  String body;

  CreateCommentRes({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CreateCommentRes.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentResFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentResToJson(this);
}
