// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_information_model_res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetPostsInformationResAdapter
    extends TypeAdapter<GetPostsInformationRes> {
  @override
  final int typeId = 1;

  @override
  GetPostsInformationRes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetPostsInformationRes();
  }

  @override
  void write(BinaryWriter writer, GetPostsInformationRes obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetPostsInformationResAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
