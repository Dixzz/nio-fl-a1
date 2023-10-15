import 'package:flutter/widgets.dart';
import 'package:nio_demo/gen/assets.gen.dart';

extension AssetGenImageExt on AssetGenImage {
  /// Use to load images from asset using [Assets.images]
  /// Added extension fun to load from internal plugin
  Image toImage({double? width, double? height, Color? color}) =>
      image(width: width, height: height, color: color);

  ImageProvider toProvider() => provider();
}
