import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/src/services/asset_bundle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glob/glob.dart';

// Temporary shim while waiting for tests to support rootBundle in Flutter.
// https://github.com/flutter/flutter/issues/12999
// TODO delete this class.
class DiskAssetBundle extends CachingAssetBundle {
  static const _assetManifestDotJson = 'AssetManifest.json';

  static Future<AssetBundle> loadAssets(List<String> assets) async {
    final cache = <String, ByteData>{};
    for (final asset in assets) {
      await for (final path in Glob(asset).list(root: "")) {
        if (path is File) {
          final bytes = await path.readAsBytes() as Uint8List;
          cache[asset] = await ByteData.view(bytes.buffer);
        }
      }
    }
    final manifest = <String, List<String>>{};
    cache.forEach((key, _) {
      manifest[key] = [key];
    });

    cache[_assetManifestDotJson] = ByteData.view(
      Uint8List.fromList(jsonEncode(manifest).codeUnits).buffer,
    );

    return DiskAssetBundle._(cache);
  }

  final Map<String, ByteData> _cache;

  DiskAssetBundle._(this._cache);

  @override
  Future<ByteData> load(String key) async {
    return _cache[key];
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    var data = _cache[key];
    var buff = data.buffer;
    return utf8.decode(buff.asUint8List());
  }
}
