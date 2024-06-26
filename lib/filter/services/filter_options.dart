enum FilterOptions {
  bestBeforeDate('Mindesthaltbarkeitsdatum'),
  name('Name'),
  created('Erstellt am');

  const FilterOptions(this.label);

  final String label;
}