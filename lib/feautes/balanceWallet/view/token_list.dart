import 'package:flutter/material.dart';
import 'package:web3_application/feautes/balanceWallet/widgets/vertical_list_tokens.dart';
import 'package:web3_application/user_wallet_info.dart';

//*Получаем все токены,так же вызывается функция получения из инхерита
//TODO: Внедрить riverpod

class TokenList extends StatelessWidget {
  const TokenList({super.key});
  @override
  Widget build(BuildContext context) {
    final allBalancerUSD = BalanceInherit.of(context);

    //!
    allBalancerUSD.counterBalance();
    return ListenableBuilder(
        listenable: allBalancerUSD,
        builder: (context, child) {
          return allBalancerUSD.allTokens == null
              ? CircularProgressIndicator()
              : listTokens(allBalancerUSD.allTokens!);
        });
  }
}
