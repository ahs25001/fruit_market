import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final client = Supabase.instance.client;
  static Future<String> uploadeImage(File? image) async {
    String imagePath = "Products/${DateTime.now().toIso8601String()}.png";

    var buckets = await client.storage.listBuckets();
    bool imageBucketIsExist = false;
    for (var element in buckets) {
      if (element.id == "images") {
        imageBucketIsExist = true;
      }
    }
    if (!imageBucketIsExist) {
      client.storage.createBucket("images", BucketOptions(public: true));
    }
    StorageFileApi imageStorageFileApi = client.storage.from("images");
    await imageStorageFileApi.upload(imagePath, image!);
    String imageUrl = imageStorageFileApi.getPublicUrl(imagePath);
    return imageUrl;
  }
}
