import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smellsense/app/theme.dart';

@staticIconProvider
class AssetProvider {
  static final checkboxIcon =
      Icon(Icons.check_box, color: AppTheme.colors().blue);

  Future<ByteData> load(String assetName) async {
    return rootBundle.load("lib/assets/svg/reactions/$assetName.svg");
  }

  AssetImage getImage(String imageName) {
    return AssetImage(imageName);
  }

  SvgPicture getIcon(String assetName) {
    return SvgPicture.asset("lib/assets/svg/reactions/$assetName.svg");
  }

  Future<dynamic> loadJSON(String assetName) async {
    final data = await load(assetName);
    return await compute(json.decode, utf8.decode(data.buffer.asUint8List()));
  }
}
