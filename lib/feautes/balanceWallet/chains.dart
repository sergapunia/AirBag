class Chains {
  static Map chains = {
    "bsc": Chain(
      name: "bsc",
      fullName: "BNB Chain",
      net: "BEP-20",
      logo: "https://docs.moralis.io/img/content/bsc.png",
    ),
    "eth": Chain(
      name: "eth",
      fullName: "Etherium Chain",
      net: "ETC-20",
      logo: "https://docs.moralis.io/img/content/eth.png",
    ),
    "polygon": Chain(
      name: "polygon",
      fullName: "Polygon Chain",
      net: "Matic",
      logo: "https://docs.moralis.io/img/content/polygon.png",
    ),
    "arbitrum": Chain(
      name: "arbitrum",
      fullName: "Arbitrum Chain",
      net: "ERC-20(L2)",
      logo: "https://docs.moralis.io/img/content/arbitrum.png",
    ),
    "avalanche": Chain(
      name: "avalanche",
      fullName: "Avalanche Chain",
      net: "AVAX",
      logo: "https://docs.moralis.io/img/content/avalanche.png",
    ),
    "optimism": Chain(
      name: "optimism",
      fullName: "Optimism Chain",
      net: "ERC-20(L2)",
      logo: "https://docs.moralis.io/img/content/optimism.png",
    ),
  };
}

class Chain {
  Chain(
      {required this.name,
      required this.fullName,
      required this.net,
      required this.logo});
  final String name;
  final String fullName;
  final String net;
  final String logo;
}
