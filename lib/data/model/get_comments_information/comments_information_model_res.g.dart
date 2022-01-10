// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_information_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCommentsInformationRes _$GetCommentsInformationResFromJson(
        Map<String, dynamic> json) =>
    GetCommentsInformationRes(
      postId: json['postId'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$GetCommentsInformationResToJson(
        GetCommentsInformationRes instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
