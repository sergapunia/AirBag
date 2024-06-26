import "package:http/http.dart" as http;
import "package:web3_application/feautes/balanceWallet/chains.dart";
import "package:web3_application/user_wallet_info.dart";
import "dart:convert";
import "models/token_model.dart";

//import "package:web3_application/my_test.dart";

//*Получаем данные о токенах

Future<List<Token>> getBalanceCrypto() async {
  List<String> activeChains = UserWallet.chains;
  String wallet = UserWallet.wallet;
  String devKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6IjJlOTVkNzYxLTRjZGQtNDYzMy05M2E4LTNjMWM4NTZlNDg0MSIsIm9yZ0lkIjoiMzk1MDM5IiwidXNlcklkIjoiNDA1OTMxIiwidHlwZUlkIjoiNDMzZjNhN2UtNjkyZS00Y2UyLTlmMzItN2I4MWU5MGE0NDdjIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MTc1MTgzMzgsImV4cCI6NDg3MzI3ODMzOH0.zZey-e2zTHv5AsTXRgpWa_fqB_mBIzHrrETPB_9lKvE";
  Map<String, String> headers = {
    "Accept": "application/json",
    "X-API-Key": devKey
  };
  List<Token> result = [];

  for (int i = 0; i < activeChains.length; i += 1) {
    Chain chain = Chains.chains[activeChains[i]];
    String url =
        'https://deep-index.moralis.io/api/v2.2/wallets/$wallet/tokens?chain=${chain.name}&exclude_spam=True&exclude_unverified_contracts=True';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    final data = response.body;
    final body = jsonDecode(data) as Map<String, dynamic>;
    //final body = testMapBalance(); //тестовая
    result += fromJsonBalance(body["result"], chain);
  }
  return result;
}

List<Token> fromJsonBalance(List data, Chain chain) {
  List<Token> listToken = [];
  data.forEach((element) {
    listToken.add(Token(
        chain: chain,
        adress: element["token_address"],
        symbol: element["symbol"],
        name: element["name"],
        logo: element["logo"],
        balance: double.parse(element["balance_formatted"]),
        price: element["usd_price"] as double,
        changePercent24h: element["usd_price_24hr_percent_change"] as double,
        changeUsd24h: element["usd_price_24hr_usd_change"] as double,
        balanceUsdValue: element["usd_value"] as double,
        balanceChange24h: element["usd_value_24hr_usd_change"] as double,
        percentInPartfolio: element["portfolio_percentage"].toDouble()));
  });
  return listToken;
}
