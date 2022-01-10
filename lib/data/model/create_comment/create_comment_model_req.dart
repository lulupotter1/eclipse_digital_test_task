import 'package:json_annotation/json_annotation.dart';

part 'create_comment_model_req.g.dart';

@JsonSerializable()
class CreateCommentReq {
  String name;
  String email;
  String body;

  CreateCommentReq({
    required this.name,
    required this.email,
    required this.body,
  });

  factory CreateCommentReq.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentReqToJson(this);
}
