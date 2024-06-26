import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageService {
  static Future<http.Response> uploadImage(
      File imageFile, String idNumber) async {
    // var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.79:8080/image/compare')); //실제 기기 테스트용
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8081/image/compare'));

    List<int> imageBytes = await imageFile.readAsBytes();
    String fileName = imageFile.path.split('/').last;

    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: fileName,
      contentType: MediaType('image', 'jpeg'),
    ));

    request.fields['buildingNumber'] = idNumber;

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}
