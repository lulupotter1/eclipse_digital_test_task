// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentRes _$CreateCommentResFromJson(Map<String, dynamic> json) =>
    CreateCommentRes(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$CreateCommentResToJson(CreateCommentRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
