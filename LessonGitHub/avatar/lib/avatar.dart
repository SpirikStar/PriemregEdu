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

Future<void> downloadImage({
  int index = 1,
  required HttpClientResponse response,
  required String path
}) async {
  var file = File("$path/$index.jpeg");
  await response.pipe(file.openWrite());
  // TODO: Все объекты необходимо переместить в папку lib
  // TODO: Если изображение ранее было скачено - не скачивать его.
}

Future<HttpClientResponse> getResponse({
  required String url,
  required HttpClient client,
}) async {
  var request = await client.getUrl(Uri.parse(url));
  var response = await request.close();
  return response;
}
