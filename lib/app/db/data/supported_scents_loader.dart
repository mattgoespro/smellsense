import 'package:json_annotation/json_annotation.dart';

part 'supported_scents_loader.g.dart';

@JsonSerializable()
class SupportedScents {
  List<SupportedScent> scents;

  SupportedScents() : scents = [];

  factory SupportedScents.fromJson(Map<String, dynamic> json) =>
      _$SupportedScentsFromJson(json);
}

@JsonSerializable()
class SupportedScent {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  SupportedScent(this.id, this.name);

  factory SupportedScent.fromJson(Map<String, dynamic> json) =>
      _$SupportedScentFromJson(json);
}

@JsonLiteral('../../../../assets/db_data/supported_scents.json')
List<Map<String, String>> get glossaryData => _$glossaryDataJsonLiteral;
