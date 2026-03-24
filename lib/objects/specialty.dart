enum Specialty {
  t_mhx,
  dioik,
  t_syn,
  diax,
  t_hn,
  hn_hy,
  b_nos,
  arm,
  t_opl,
  t_dom,
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
          Specialty.b_nos: 'Β/ΝΟΣ',
          Specialty.arm: 'ΑΡΜ',
          Specialty.t_opl: 'Τ/ΟΠΛ',
          Specialty.t_dom: 'Τ/ΔΟΜ',
          Specialty.hl: 'ΗΛ',
        }[this] ??
        'Τ/ΗΝ';
  }
}
