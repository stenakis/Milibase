enum Specialty {
  t_mhx,
  dioik,
  t_syn,
  diax,
  t_hn,
  hn_hy,
  hl;

  static Specialty fromString(String value) {
    return Specialty.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Specialty.dioik, // Default fallback
    );
  }

  String get label {
    return {
          Specialty.t_mhx: 'Τ/ΜΗΧ',
          Specialty.dioik: 'ΔΙΟΙΚ',
          Specialty.t_syn: 'Τ/ΣΥΝ',
          Specialty.diax: 'ΔΙΑΧ',
          Specialty.t_hn: 'Τ/ΗΝ',
          Specialty.hn_hy: 'ΗΝ/ΗΥ',
          Specialty.hl: 'ΗΛ',
        }[this] ??
        'Τ/ΗΝ';
  }
}
