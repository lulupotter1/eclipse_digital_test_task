// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_information_model_res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetPhotosInformationResAdapter
    extends TypeAdapter<GetPhotosInformationRes> {
  @override
  final int typeId = 4;

  @override
  GetPhotosInformationRes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetPhotosInformationRes();
  }

  @override
  void write(BinaryWriter writer, GetPhotosInformationRes obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetPhotosInformationResAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
