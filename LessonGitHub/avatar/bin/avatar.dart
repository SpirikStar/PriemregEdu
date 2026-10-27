import 'dart:io';
import 'package:avatar/avatar.dart' as lib;

void main() async {
  var assets = 'assets/images';
  await lib.createDir(baseAssets: Directory(assets));
  var client = HttpClient();
  for (var index = 1; index < 5; index++) {
    var response = await lib.getResponse(
      url: "https://avatars.githubusercontent.com/u/$index",
      client: client,
    );
    await lib.downloadImage(index: index, response: response, path: assets);
  }
  client.close();
}
