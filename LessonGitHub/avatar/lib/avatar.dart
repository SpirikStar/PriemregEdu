import 'dart:io';

Future<bool> isDir({required Directory baseAssets}) async {
  return await baseAssets.exists();
}

Future<void> createDir({required Directory baseAssets}) async {
  if (await isDir(baseAssets: baseAssets)) {
    return;
  }
  baseAssets.create(recursive: true);
}

Future<bool> isImage({required int index, required List images}) async {
  return images.contains('$index.jpeg');
}
Future<List> getImages({required Directory dir}) async {
  var images = [];
  try{
    await for (var entity in dir.list()) {
      images.add(entity.path.split('/')[2]);
    }
  }
  catch(ex){ print(ex);}
  return images;
}

Future<void> downloadImage({
  int index = 1,
  required HttpClientResponse response,
  required String path
}) async {
  var file = File("$path/$index.jpeg");
  await response.pipe(file.openWrite());
}

Future<HttpClientResponse> getResponse({
  required String url,
  required HttpClient client,
}) async {
  var request = await client.getUrl(Uri.parse(url));
  var response = await request.close();
  return response;
}
