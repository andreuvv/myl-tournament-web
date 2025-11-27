class BanListData {
  final String format;
  final String lastUpdated;
  final List<CardData> banned;
  final List<CardData> limitedX1;
  final List<CardData> limitedX2;

  BanListData({
    required this.format,
    required this.lastUpdated,
    required this.banned,
    required this.limitedX1,
    required this.limitedX2,
  });

  factory BanListData.fromJson(Map<String, dynamic> json) {
    return BanListData(
      format: json['format'] as String,
      lastUpdated: json['lastUpdated'] as String,
      banned: (json['banned'] as List)
          .map((card) => CardData.fromJson(card))
          .toList(),
      limitedX1: (json['limitedX1'] as List)
          .map((card) => CardData.fromJson(card))
          .toList(),
      limitedX2: (json['limitedX2'] as List)
          .map((card) => CardData.fromJson(card))
          .toList(),
    );
  }
}

class CardData {
  final String name;
  final String type;
  final String imageUrl;

  CardData({
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      name: json['name'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
