extension NonNullString on String? {
  String? OrEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

extension NoNullInt on int? {
  int? OrZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
