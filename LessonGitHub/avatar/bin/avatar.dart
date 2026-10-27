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
}) async {
  var file = File("assets/images/$index.jpeg");
  await response.pipe(file.openWrite());
  // TODO: Если данного вложения assets/images - нет, скрипт должен его создать. ОТДЕЛЬНЫМ ОБЪЕКТОМ!
  // TODO: Все объекты необходимо переместить в папку lib
  // TODO: Найти недостатки и оптимизировать.
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

void main() async {
  var assets = 'assets/images';
  await createDir(baseAssets: Directory(assets));
  var client = HttpClient();
  for (var index = 1; index < 5; index++) {
    var response = await getResponse(
      url: "https://avatars.githubusercontent.com/u/$index",
      client: client,
    );
    // await downloadImage(index: index, response: response);
  }
  client.close();
}
