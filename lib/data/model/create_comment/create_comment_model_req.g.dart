// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentReq _$CreateCommentReqFromJson(Map<String, dynamic> json) =>
    CreateCommentReq(
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$CreateCommentReqToJson(CreateCommentReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
