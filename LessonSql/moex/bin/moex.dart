import 'dart:convert';
import 'dart:io';

dynamic getBody(Uri url) async {
  final client = HttpClient();
  final request = await client.getUrl(url);
  final response = await request.close();
  final body = await response.transform(utf8.decoder).join();
  if (response.statusCode != 200) {
    return;
  }
  return body;
}

void main() async {
  final url = Uri.parse(
    "https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities.json"
    '?iss.meta=off&iss.only=securities,marketdata,dataversion'
    '&securities.columns=SECID,SHORTNAME'
    '&marketdata.columns=SECID,LAST,TIME'
    '&dataversion.columns=trade_date',
  );
  final body = await getBody(url);
  if (body == null) {
    return;
  }

  final json = jsonDecode(body) as Map<String, dynamic>;
  final tradeDate = json['dataversion']['data'][0][0];
  final names = json['securities']['data'] as List;
  final market = {
    for (final row in json['marketdata']['data'] as List)  row[0] as String: row
  };
  for (final row in names) {
    final code = row[0] as String;
    final quote = market[code];
    final title = row[1];
    final price = quote?[1] ?? '-';
    final time = quote?[2];
    print('$code - $title - $price - $time');

  }
}
