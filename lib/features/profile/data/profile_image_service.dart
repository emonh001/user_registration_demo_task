import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileImageService {
  final ImagePicker _picker = ImagePicker();

  // PICK FROM GALLERY
  Future<File?> pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return null;

    return File(picked.path);
  }

  // CAPTURE FROM CAMERA
  Future<File?> captureFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);

    if (picked == null) return null;

    return File(picked.path);
  }

  // COPY IMAGE TO APP STORAGE (PERSISTENT)
  Future<String> saveToLocalDirectory(File file) async {
    final dir = await getApplicationDocumentsDirectory();

    final fileName = basename(file.path);

    final savedImage = await file.copy('${dir.path}/$fileName');

    return savedImage.path;
  }
}