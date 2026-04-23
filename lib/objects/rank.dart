enum Rank {
  diopos,
  naftis;

  static Rank fromString(String value) {
    return Rank.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Rank.naftis,
    );
  }

  String get label => switch (this) {
    Rank.naftis => 'Ναύτης',
    Rank.diopos => 'Σ. Δίοπος',
  };
}
