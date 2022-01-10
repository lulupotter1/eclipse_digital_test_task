// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_information_model_res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetAlbumsInformationResAdapter
    extends TypeAdapter<GetAlbumsInformationRes> {
  @override
  final int typeId = 2;

  @override
  GetAlbumsInformationRes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetAlbumsInformationRes();
  }

  @override
  void write(BinaryWriter writer, GetAlbumsInformationRes obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAlbumsInformationResAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
