import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

enum ImageType { plate, actual }

class StorageService {
  final FirebaseStorage _firebaseStorage;
  static final StorageService instance =
      StorageService(FirebaseStorage.instance);

  StorageService(this._firebaseStorage);

  Future<String> uploadFile(
      String filePath, String foodId, ImageType type) async {
    String path;

    switch (type) {
      case ImageType.plate:
        path = "plate";
        break;
      case ImageType.actual:
        path = "actual";
        break;
    }

    try {
      File file = File(filePath);
      TaskSnapshot snapshot = await _firebaseStorage
          .ref()
          .child('food_images/$foodId/$path')
          .putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
