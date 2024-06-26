import 'package:flutter/material.dart';
import 'package:web3_application/user_wallet_info.dart';
import "screens/screens.dart";

void main() {
  runApp(
    BalanceInherit(
      balanceService: BalanceService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
