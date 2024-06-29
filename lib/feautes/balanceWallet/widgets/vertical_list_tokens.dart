import 'package:flutter/material.dart';
import 'package:web3_application/textStyles/text_styles.dart';
import '../../../repositories/repositories.dart';

Widget listTokens(List<Token> data) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      Token token = data[index];
      return cellToken(token);
    },
  );
}

Widget cellToken(Token token) {
  return Container(
    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
    margin: const EdgeInsets.all(3),
    decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(10), left: Radius.circular(10))),
    height: 90,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        leftLogo(token),
        const SizedBox(width: 20),
        middleInfo(token),
        Expanded(
          child: rightInfo(token),
        ),
      ],
    ),
  );
}

Widget leftLogo(token) {
  return Stack(alignment: Alignment.bottomRight, children: [
    token.logo != null
        ? Image.network(
            token.logo,
            fit: BoxFit.contain,
          )
        : Image.asset("assets/icons/logoIcon.png"),
    Align(
      alignment: Alignment.bottomRight,
      child: Image.network(
        token.chain.logo,
        fit: BoxFit.contain,
        height: 30,
      ),
    ),
  ]);
}

Widget middleInfo(token) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(token.symbol,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Text("  (${token.chain.net})",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            token.price.toStringAsFixed(2) + " \$",
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(width: 5),
          changeText(token.changePercent24h, "%", 2, 13)
        ],
      ),
    ],
  );
}

Widget rightInfo(token) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(token.balance.toStringAsFixed(5),
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white)),
      Text(token.balanceUsdValue.toStringAsFixed(3) + " \$",
          style: const TextStyle(fontSize: 15, color: Colors.white)),
      changeText(token.balanceChange24h, "\$", 3, 13)
    ],
  );
}
