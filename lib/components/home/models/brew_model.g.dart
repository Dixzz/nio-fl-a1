// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brew_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrewItem _$BrewItemFromJson(Map<String, dynamic> json) => BrewItem(
      json['first_brewed'] as String,
      json['name'] as String,
      json['description'] as String,
      json['image_url'] as String,
      json['abv'] as num? ?? 0,
      json['ibu'] as num? ?? 0,
      json['id'] as int,
    );

Map<String, dynamic> _$BrewItemToJson(BrewItem instance) => <String, dynamic>{
      'id': instance.id,
      'first_brewed': instance.firstBrewed,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.url,
      'abv': instance.abv,
      'ibu': instance.ibu,
    };
