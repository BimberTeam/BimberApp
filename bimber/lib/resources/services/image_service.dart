import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

const ENV_NAME = "IMAGE_SERVER_PREFIX";

class ImageUploadException implements Exception {
  String message;

  ImageUploadException({@required this.message});

  @override
  String toString() {
    return 'ImageUploadException { message: $message }';
  }
}

class ImageService {
  static String getImageUrl(String userId) {
    final prefix = DotEnv().env[ENV_NAME];

    return prefix + userId;
  }

  static String _getExtension(String filename) {
    var index = filename.lastIndexOf('.');
    return filename.substring(index);
  }

  static Future<void> uploadImage(
      {@required String userId,
      @required String token,
      @required File image}) async {
    Dio dio = Dio();
    print(token);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path,
          filename: userId + _getExtension(image.path))
    });

    final prefix = DotEnv().env[ENV_NAME];

    final path = prefix + userId;

    try {
      print(_getExtension(image.path));
      final options = Options(headers: <String, String>{
        "Authorization": token,
      });
      final response = await dio.post(path, data: formData, options: options);
      if (response.statusCode != 200) {
        throw ImageUploadException(message: response.data.toString());
      }

      await CachedNetworkImage.evictFromCache(path);

      return;
    } on DioError catch (e) {
      throw ImageUploadException(message: e.response.data.toString());
    }
  }
}
