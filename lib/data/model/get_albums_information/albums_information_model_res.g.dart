// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_information_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAlbumsInformationRes _$GetAlbumsInformationResFromJson(
        Map<String, dynamic> json) =>
    GetAlbumsInformationRes(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$GetAlbumsInformationResToJson(
        GetAlbumsInformationRes instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
    };
