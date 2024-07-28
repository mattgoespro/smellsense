import 'package:json_annotation/json_annotation.dart';

part 'supported_training_scent_data.g.dart';

class SupportedTrainingScentData {
  List<SupportedTrainingScent>? scents;

  SupportedTrainingScentData({this.scents});

  factory SupportedTrainingScentData.fromJson(
    List<Map<String, String>> json,
  ) =>
      SupportedTrainingScentData(
        scents: json.map(_$SupportedTrainingScentFromJson).toList(),
      );
}

@JsonSerializable()
class SupportedTrainingScent {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  SupportedTrainingScent(this.id, this.name);

  factory SupportedTrainingScent.fromJson(Map<String, String> json) =>
      _$SupportedTrainingScentFromJson(json);
}

@JsonLiteral('../../../../assets/db_data/supported_scents.json')
List<Map<String, String>> get supportedScentsData =>
    _$supportedScentsDataJsonLiteral;
