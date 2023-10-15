
import 'package:flutter/material.dart';

class SymmetricSizeBoxedProgressIndicator extends SizedBox {
  final double size;

  const SymmetricSizeBoxedProgressIndicator({super.key, this.size = 35})
      : super(width: size, height: size, child: const  CircularProgressIndicator(strokeWidth: 3,));
}