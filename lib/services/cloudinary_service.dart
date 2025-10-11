import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String> uploadBytes(List<int> bytes,
      {String fileName = 'foto.jpg'}) async {
    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final req = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files
          .add(http.MultipartFile.fromBytes('file', bytes, filename: fileName));
    final res = await http.Response.fromStream(await req.send());
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      return json['secure_url'] as String;
    }
    throw Exception('Falha no upload Cloudinary: ${res.statusCode}');
  }
}
