import 'package:flutter/material.dart';
import 'repositories/position/get_position.dart';
import 'repositories/position/models/protocol_and_positions.dart';
import 'repositories/repositories.dart';

class UserWallet {
  static String wallet = "0xa6d10A7D9d752A487fe344c6320eF98fE0Be01A6";
  static List<String> chains = ["bsc", "avalanche"];
}

class BalanceInherit extends InheritedWidget {
  final BalanceService balanceService;

  BalanceInherit({
    required this.balanceService,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(BalanceInherit oldWidget) {
    return true;
    // return oldWidget.balanceService !=
    //     balanceService; //Для определения момента обновления виджета
  }

  static BalanceService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BalanceInherit>()!
        .balanceService; //Для доступа к полям данных
  }
}

class BalanceService extends ChangeNotifier {
  double? allTokenUSD;
  double? change24h;
  List<Token>? allTokens;
  //TODO: Внедрить список протоколов
  Protocol? protocolPositions;
  void counterBalance() async {
    print("FUNCTION ACTIVATE");
    List<Token> tokens = await getBalanceCrypto();
    protocolPositions = await getPositions();
    double newBalance = 0;
    double newChange = 0;
    tokens.forEach((token) {
      newBalance += token.balanceUsdValue;
      newChange += token.balanceChange24h;
    });
    protocolPositions != null
        ? newBalance += protocolPositions!.totalUsdInPositions +
            protocolPositions!.unclaimedUsd
        : null;
    allTokenUSD = newBalance;
    change24h = newChange;
    allTokens = tokens;
    notifyListeners();
  }
}
