import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_information_model_res.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class GetUserInformationRes extends HiveObject {
  int? id;
  String? name;
  String? username;
  String? email;
  Map? adress;
  String? phone;
  String? website;
  Map? company;

  GetUserInformationRes({
    this.id,
    this.name,
    this.username,
    this.email,
    this.adress,
    this.phone,
    this.website,
    this.company,
  });

  factory GetUserInformationRes.fromJson(Map<String, dynamic> json) =>
      _$GetUserInformationResFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserInformationResToJson(this);
}
