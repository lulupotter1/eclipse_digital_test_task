// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_information_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPhotosInformationRes _$GetPhotosInformationResFromJson(
        Map<String, dynamic> json) =>
    GetPhotosInformationRes(
      albumId: json['albumId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$GetPhotosInformationResToJson(
        GetPhotosInformationRes instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
