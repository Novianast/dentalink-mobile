import 'dart:js_interop';
import 'dart:typed_data';
import 'package:web/web.dart' as web;

Future<String> savePrescriptionPng(Uint8List pngBytes) async {
  final blob = web.Blob([pngBytes.toJS].toJS);
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement();
  anchor.href = url;
  anchor.setAttribute('download', 'resep_digital.png');
  anchor.click();
  web.URL.revokeObjectURL(url);
  return "Resep berhasil diunduh (browser)";
}
