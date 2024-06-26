
class Protocol {
  String protocol;
  String urlProtocol;
  String protocolLogo;
  double totalUsdInPositions;
  double unclaimedUsd;
  List<Position> positions;
  Protocol({
    required this.protocol,
    required this.urlProtocol,
    required this.protocolLogo,
    required this.totalUsdInPositions,
    required this.unclaimedUsd,
    required this.positions,
  });
}

class TokenInPosition {
  String type;
  String name;
  String symbol;
  String logo;
  double balance;
  double usdPrice;
  double usdBalance;
  TokenInPosition({
    required this.type,
    required this.name,
    required this.symbol,
    required this.logo,
    required this.balance,
    required this.usdPrice,
    required this.usdBalance,
  });
}

class Position {
  String label;
  String address;
  double balanceUsd;
  double unclaimedUsd;
  List<TokenInPosition> rewardTokens;
  List<TokenInPosition> unclaimedTokens;
  bool inRange;
  double lowerPrice;
  double upperPrice;
  String title;
  double percentIncome;
  String nameNFT;
  String imgNFT;
  Position({
    required this.label,
    required this.address,
    required this.balanceUsd,
    required this.unclaimedUsd,
    required this.rewardTokens,
    required this.unclaimedTokens,
    required this.inRange,
    required this.lowerPrice,
    required this.upperPrice,
    required this.title,
    required this.percentIncome,
    required this.nameNFT,
    required this.imgNFT,
  });
}
