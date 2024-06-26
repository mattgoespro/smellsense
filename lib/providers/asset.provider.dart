import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Service class that loads and performs actions on platform assets from an AssetBundle

class AssetProvider {
  final bundle = PlatformAssetBundle();

  /// Load an asset from the asset bundle
  Future<ByteData> load(String assetName) async {
    return bundle.load(assetName);
  }

  /// Load an image from the asset bundle
  Future<Image> loadImage(String assetName) async {
    final data = await load(assetName);
    final bytes = data.buffer.asUint8List();
    final image = Image.memory(bytes);
    return image;
  }

  Future<dynamic> loadJSON(String assetName) async {
    final data = await load(assetName);
    return await compute(json.decode, utf8.decode(data.buffer.asUint8List()));
  }
}
