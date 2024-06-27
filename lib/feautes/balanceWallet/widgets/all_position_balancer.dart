import 'package:flutter/material.dart';
import 'package:web3_application/user_wallet_info.dart';

import '../../../repositories/position/models/protocol_and_positions.dart';


//TODO: УБРАТЬ ХАРДКОД!
class PositionBalance extends StatelessWidget {
  const PositionBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final allBalance = BalanceInherit.of(context);
    return ListenableBuilder(
        listenable: allBalance,
        builder: (context, child) {
          Protocol? protocol = allBalance.protocolPositions;
          return protocol == null
              ? const CircularProgressIndicator()
              : Container(
                  height: 250,
                  child: Column(
                    children: [
                      
                      uppContainerProtocol(protocol),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: protocol.positions.length,
                            itemBuilder: (context, index) {
                              Position pos = protocol.positions[index];
                              return Container(
                                width: 250,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(15),
                                        left: Radius.circular(15))),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pos.title,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          pos.inRange == true
                                              ? "In Range"
                                              : "Not in Range",
                                          style: TextStyle(
                                              color: pos.inRange == true
                                                  ? Colors.green
                                                  : Colors.orange,
                                              fontSize: 12),
                                        ),
                                        Text(
                                            pos.lowerPrice.toString() +
                                                "<>" +
                                                pos.upperPrice.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          pos.balanceUsd.toStringAsFixed(2) +
                                              "\$" +
                                              " | " +
                                              pos.unclaimedUsd
                                                  .toStringAsFixed(2) +
                                              "\$",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        rowTokenBalance(pos, 0),
                                        rowTokenBalance(pos, 1),
                                        Text(
                                            "Price: " +
                                                pos.rewardTokens[0].usdPrice
                                                    .toStringAsFixed(2) +
                                                "\$ | " +
                                                pos.rewardTokens[1].usdPrice
                                                    .toStringAsFixed(2) +
                                                "\$",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Text(pos.percentIncome.toString() + "%",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
        });
  }
}

Widget rowTokenBalance(Position pos, int index) {
  return Row(children: [
    Container(
      child: Image.network(
        pos.rewardTokens[index].logo,
        height: 13,
      ),
    ),
    Text(
      pos.rewardTokens[index].balance.toStringAsFixed(5) +
          " | " +
          pos.unclaimedTokens[index].balance.toStringAsFixed(5) +
          " (${(pos.rewardTokens[index].usdBalance + pos.unclaimedTokens[index].usdBalance).toStringAsFixed(3)}\$)",
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    ),
  ]);
}

Widget uppContainerProtocol(Protocol protocol) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(15), left: Radius.circular(15))),
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(
          protocol.protocolLogo,
          fit: BoxFit.fill,
          height: 40,
        ),
        Column(
          children: [
            Text(
              protocol.totalUsdInPositions.toStringAsFixed(3) + " \$",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "+ " + protocol.unclaimedUsd.toStringAsFixed(3) + " \$",
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(protocol.protocol,
            style: const TextStyle(
                fontSize: 20, color: Colors.pink, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
