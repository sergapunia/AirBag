import "package:http/http.dart" as http;
//import "package:web3_application/my_test.dart";
import "dart:convert";

import "../../user_wallet_info.dart";
import "models/protocol_and_positions.dart";

Future<Protocol> getPositions() async {
  String wallet = UserWallet.wallet;
  String devKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6IjJlOTVkNzYxLTRjZGQtNDYzMy05M2E4LTNjMWM4NTZlNDg0MSIsIm9yZ0lkIjoiMzk1MDM5IiwidXNlcklkIjoiNDA1OTMxIiwidHlwZUlkIjoiNDMzZjNhN2UtNjkyZS00Y2UyLTlmMzItN2I4MWU5MGE0NDdjIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MTc1MTgzMzgsImV4cCI6NDg3MzI3ODMzOH0.zZey-e2zTHv5AsTXRgpWa_fqB_mBIzHrrETPB_9lKvE";
  Map<String, String> headers = {
    "Accept": "application/json",
    "X-API-Key": devKey
  };

  //TODO: Вынести в настройки юзера
  String chain = "bsc";
  String protocol = "uniswap-v3";
  String url =
      "https://deep-index.moralis.io/api/v2.2/wallets/$wallet/defi/$protocol/positions?chain=$chain";
  final uri = Uri.parse(url);
  final response = await http.get(uri, headers: headers);
  final body = response.body;
  final data = jsonDecode(body) as Map<String, dynamic>;
  //final data = testPositions() as Map<String, dynamic>; // для тестов
  return fromJsonProtocol(data);
}

Protocol fromJsonProtocol(Map<String, dynamic> data) {
  List<Position> positions = [];
  data["positions"].forEach((pos) {
    Map posDetails = pos["position_details"];
    String nameNFT = posDetails["nft_metadata"]["name"];
    List tokens = pos["tokens"];
    List<TokenInPosition> rewardTokens = [];
    List<TokenInPosition> suppliedTokens = [];
    tokens.forEach((token) {
      TokenInPosition t = TokenInPosition(
        type: token["token_type"],
        name: token["name"],
        symbol: token["symbol"],
        logo: token["logo"],
        balance: double.parse(token["balance_formatted"]),
        usdPrice: token["usd_price"] as double,
        usdBalance: token["usd_value"].toDouble(),
      );
      t.type == "supplied" ? suppliedTokens.add(t) : rewardTokens.add(t);
    });

    positions.add(Position(
      label: pos["label"],
      address: pos["address"],
      balanceUsd: pos["balance_usd"] as double,
      unclaimedUsd: pos["total_unclaimed_usd_value"] as double,
      inRange: posDetails["is_in_range"] as bool,
      lowerPrice: double.parse(nameNFT.split("<>")[0].split("- ").last),
      upperPrice: double.parse(nameNFT.split("<>").last),
      title: posDetails["price_label"],
      percentIncome: posDetails["fee_tier"] as double,
      nameNFT: nameNFT,
      imgNFT: posDetails["nft_metadata"]["image"],
      rewardTokens: rewardTokens,
      unclaimedTokens: suppliedTokens,
    ));
  });
  return Protocol(
      protocol: data["protocol_name"],
      urlProtocol: data["protocol_url"],
      protocolLogo: data["protocol_logo"],
      totalUsdInPositions: data["total_usd_value"] as double,
      unclaimedUsd: data["total_unclaimed_usd_value"] as double,
      positions: positions);
}
