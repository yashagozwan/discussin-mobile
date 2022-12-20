import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  final _cloudinary = Cloudinary.full(
    apiKey: '774645422996897',
    apiSecret: 'zpo9CFhmpUJ3qOb_ttUJTnNZ9Lc',
    cloudName: 'dk0q3rmmm',
  );

  Future<String?> uploadImage(XFile xFile) async {
    try {
      final cloudinaryResult = await _cloudinary.uploadResource(
        CloudinaryUploadResource(
          resourceType: CloudinaryResourceType.image,
          fileBytes: await xFile.readAsBytes(),
          folder: 'discuss',
          fileName: '${DateTime.now().millisecondsSinceEpoch}',
        ),
      );
      return cloudinaryResult.url;
    } on Exception {
      rethrow;
    }
  }
}
