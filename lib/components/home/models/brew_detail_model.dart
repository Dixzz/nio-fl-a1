import 'package:json_annotation/json_annotation.dart';
import 'package:nio_demo/components/home/models/brew_model.dart';

part 'brew_detail_model.g.dart';

@JsonSerializable()
class BrewItemDetailed extends BrewItem {
  @JsonKey(name: 'target_fg', defaultValue: 0)
  final num targetFg;
  @JsonKey(name: 'target_og', defaultValue: 0)
  final num targetOg;
  @JsonKey(defaultValue: 0)
  final num ebc;
  @JsonKey(defaultValue: 0)
  final num srm;
  @JsonKey(defaultValue: 0)
  final num ph;

  final String tagline;
  @JsonKey(name: 'attenuation_level', defaultValue: 0)
  final num attenLevel;

  BrewItemDetailed(
      super.firstBrewed,
      super.name,
      super.description,
      super.url,
      super.abv,
      super.ibu,
      super.id,
      this.targetFg,
      this.targetOg,
      this.ebc,
      this.srm,
      this.ph,
      this.attenLevel,
      this.tagline);

  factory BrewItemDetailed.fromJson(Map<String, dynamic> json) =>
      _$BrewItemDetailedFromJson(json);

  Map<String, dynamic> toJson() => _$BrewItemDetailedToJson(this);
}
