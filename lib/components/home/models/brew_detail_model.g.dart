// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brew_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrewItemDetailed _$BrewItemDetailedFromJson(Map<String, dynamic> json) =>
    BrewItemDetailed(
      json['first_brewed'] as String,
      json['name'] as String,
      json['description'] as String,
      json['image_url'] as String,
      json['abv'] as num? ?? 0,
      json['ibu'] as num? ?? 0,
      json['id'] as int,
      json['target_fg'] as num? ?? 0,
      json['target_og'] as num? ?? 0,
      json['ebc'] as num? ?? 0,
      json['srm'] as num? ?? 0,
      json['ph'] as num? ?? 0,
      json['attenuation_level'] as num? ?? 0,
      json['tagline'] as String,
    );

Map<String, dynamic> _$BrewItemDetailedToJson(BrewItemDetailed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_brewed': instance.firstBrewed,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.url,
      'abv': instance.abv,
      'ibu': instance.ibu,
      'target_fg': instance.targetFg,
      'target_og': instance.targetOg,
      'ebc': instance.ebc,
      'srm': instance.srm,
      'ph': instance.ph,
      'tagline': instance.tagline,
      'attenuation_level': instance.attenLevel,
    };
