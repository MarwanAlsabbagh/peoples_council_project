import '../constants.dart';

String getFullMediaUrl(String? path) {
  if (path == null || path.isEmpty) {
    return kBaseMediaUrl + "storage/posts/iw7tv5HzkprT88m7kr32qDE6Qjl02hMBU07LttwG.jpg";
  }
  return kBaseMediaUrl + path;
}
