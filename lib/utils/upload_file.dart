import 'dart:convert';

import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> uploadFileToSever({
  required String path,
  bool isPrivate = false,
}) async {
  try {
    const  String uri = 'https://api-common-ccvc-uat.chinhquyendientu.vn/api/CanBo/upload';
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse(uri),
    );
    final token = PrefsService.getToken();
    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(await http.MultipartFile.fromPath('files', path));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final Map<String, dynamic> map =
      jsonDecode(await response.stream.bytesToString());
      return map['data'] as List<dynamic>;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}