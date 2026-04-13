enum Status {
  stinYphresia,
  seAdeia,
  seApomakrynsi,
  apolythike;

  static Status fromString(String value) {
    return Status.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Status.stinYphresia,
    );
  }

  String get label {
    return {
          Status.stinYphresia: 'Στην υπηρεσία',
          Status.apolythike: 'Απολύθηκε',
          Status.seAdeia: 'Σε άδεια',
          Status.seApomakrynsi: 'Σε απομάκρυνση',
        }[this] ??
        'Στην υπηρεσία';
  }
}
