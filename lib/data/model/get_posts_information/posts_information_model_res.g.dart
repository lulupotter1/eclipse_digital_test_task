// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_information_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsInformationRes _$GetPostsInformationResFromJson(
        Map<String, dynamic> json) =>
    GetPostsInformationRes(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$GetPostsInformationResToJson(
        GetPostsInformationRes instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
