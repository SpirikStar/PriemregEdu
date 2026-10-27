import 'dart:io';
import 'package:avatar/avatar.dart' as lib;


void main() async {
  var assets = 'assets/images';
  var dir = Directory(assets);
  await lib.createDir(baseAssets: dir);
  var images = await lib.getImages(dir: dir);
  var client = HttpClient();
  for (var index = 1; index < 5; index++) {
    if (await lib.isImage(index: index, images: images)){
      continue;
    }
    var response = await lib.getResponse(
      url: "https://avatars.githubusercontent.com/u/$index",
      client: client,
    );
    await lib.downloadImage(index: index, response: response, path: assets);
  }
  client.close();
}
