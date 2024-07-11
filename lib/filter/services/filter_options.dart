enum FilterOptions {
  expired_at('Mindesthaltbarkeitsdatum'),
  name('Name'),
  created_at('Erstellt am'),
  price_in_cents('Preis');

  const FilterOptions(this.label);

  final String label;
}