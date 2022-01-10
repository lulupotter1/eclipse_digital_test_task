// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_information_model_res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetCommentsInformationResAdapter
    extends TypeAdapter<GetCommentsInformationRes> {
  @override
  final int typeId = 3;

  @override
  GetCommentsInformationRes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetCommentsInformationRes();
  }

  @override
  void write(BinaryWriter writer, GetCommentsInformationRes obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCommentsInformationResAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
