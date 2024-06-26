import 'package:web3_application/feautes/balanceWallet/chains.dart';

class Token {
  Chain chain;
  String adress;
  String symbol;
  String name;
  String logo;
  double balance;
  double price;
  double changePercent24h;
  double changeUsd24h;
  double balanceUsdValue;
  double balanceChange24h;
  double percentInPartfolio;

  Token(
      {required this.chain,
      required this.adress,
      required this.symbol,
      required this.name,
      required this.logo,
      required this.balance,
      required this.price,
      required this.changePercent24h,
      required this.changeUsd24h,
      required this.balanceUsdValue,
      required this.balanceChange24h,
      required this.percentInPartfolio});
}
