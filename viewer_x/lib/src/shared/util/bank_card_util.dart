class BankCard {
  final String cardType;
  final String cardNumber;
  final String expiryDate;
  final String holderName;

  BankCard({
    required this.cardType,
    required this.cardNumber,
    required this.expiryDate,
    required this.holderName,
  });

  @override
  String toString() {
    return 'BankCard(cardType: $cardType, cardNumber: $cardNumber, expiryDate: $expiryDate, holderName: $holderName)';
  }
}

BankCard parseBankCard(String rawText) {
  // Nettoyage basique
  String cleaned = rawText.replaceAll(RegExp(r'[^A-Z0-9 /]'), ' ');

  // Détection du type de carte
  String cardType = cleaned.toLowerCase().contains("mastercard")
      ? "Mastercard"
      : cleaned.toLowerCase().contains("visa")
      ? "Visa"
      : "Unknown";

  // Extraction du numéro de carte (4 groupes de 4 chiffres ou proches)
  RegExp cardNumberRegex = RegExp(r'(\d{4}[ \-]?){3,4}');
  String cardNumber =
      cardNumberRegex
          .firstMatch(cleaned)
          ?.group(0)
          ?.replaceAll(RegExp(r'\D'), '') ??
      "Unknown";

  // Extraction de la date expiration
  RegExp dateRegex = RegExp(r'(0[1-9]|1[0-2])[/ ]?(2[0-9])');
  String expiryDate =
      dateRegex.firstMatch(cleaned)?.group(0)?.replaceAll(' ', '/') ??
      "Unknown";

  // Extraction du nom (supposé être tout en majuscules à la fin)
  RegExp nameRegex = RegExp(r'([A-Z]{2,})(\s+[A-Z]{2,})+');
  String holderName =
      nameRegex.allMatches(cleaned).map((m) => m.group(0)).lastOrNull ??
      "Unknown";

  return BankCard(
    cardType: cardType,
    cardNumber: cardNumber,
    expiryDate: expiryDate,
    holderName: holderName,
  );
}

extension LastOrNull<E> on Iterable<E> {
  E? get lastOrNull => isEmpty ? null : last;
}
