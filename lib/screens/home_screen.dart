import 'package:flutter/material.dart';
import 'package:web3_application/feautes/balanceWallet/widgets/all_position_balancer.dart';
import 'package:web3_application/feautes/balanceWallet/widgets/all_token_balance.dart';
import '../feautes/feautes.dart';
import '../textStyles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: Text("Airbag", style: myTextStyle()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AllTokenBalance(),
          PositionBalance(),
          Expanded(
            child: TokenList(),
          ),
        ],
      ),
    );
  }
}

Widget customImageButton(String asset, Function tap) {
  return GestureDetector(
    onTap: tap(),
    child: Card(
      shadowColor: Colors.blue,
      elevation: 60,
      color: Colors.transparent,
      child: Image.asset(
        asset,
        height: 70,
        width: 100,
      ),
    ),
  );
}
