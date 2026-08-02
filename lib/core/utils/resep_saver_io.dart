import 'dart:io' as io;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<String> savePrescriptionPng(Uint8List pngBytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = io.File('${directory.path}/resep_digital.png');
  await file.writeAsBytes(pngBytes);
  // ignore: deprecated_member_use
  await Share.shareXFiles([XFile(file.path)], text: 'Resep Digital DentaLink');
  return "Resep berhasil diunduh sebagai PNG";
}
