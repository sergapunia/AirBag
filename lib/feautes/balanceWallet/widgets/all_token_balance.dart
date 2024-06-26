import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3_application/textStyles/text_styles.dart';
import 'package:web3_application/user_wallet_info.dart';


//* Получаем цену всех токенов
//TODO: Внедрить riverpod


class AllTokenBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allBalanceUSD = BalanceInherit.of(context);
    return ListenableBuilder(
      listenable: allBalanceUSD,
      builder: (context, child) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage("assets/images/fone2.jpg"),
                fit: BoxFit.fill,
                colorFilter:
                    ColorFilter.mode(Colors.grey.shade500, BlendMode.darken)),
            borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))),
        height: 200,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Adress",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        UserWallet.wallet,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                        iconSize: 25,
                        color: Colors.pink,
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: UserWallet.wallet));
                        },
                        icon: const Icon(Icons.content_copy_rounded)),
                  ],
                ),
                Text(
                    allBalanceUSD.allTokenUSD == null
                        ? "0"
                        : allBalanceUSD.allTokenUSD!.toStringAsFixed(3) + " \$",
                    style: const  TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                allBalanceUSD.change24h == null
                    ? changeText(0, " \$ / 24hr", 3, 20)
                    : changeText(allBalanceUSD.change24h!, " \$ / 24hr", 3, 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
