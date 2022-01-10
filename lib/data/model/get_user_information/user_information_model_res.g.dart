// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information_model_res.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetUserInformationResAdapter extends TypeAdapter<GetUserInformationRes> {
  @override
  final int typeId = 0;

  @override
  GetUserInformationRes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetUserInformationRes();
  }

  @override
  void write(BinaryWriter writer, GetUserInformationRes obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUserInformationResAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserInformationRes _$GetUserInformationResFromJson(
        Map<String, dynamic> json) =>
    GetUserInformationRes(
      id: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      adress: json['adress'] as Map<String, dynamic>?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      company: json['company'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GetUserInformationResToJson(
        GetUserInformationRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'adress': instance.adress,
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company,
    };
