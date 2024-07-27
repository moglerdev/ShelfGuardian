import 'package:shelf_guardian/features/filter/services/filter_options.dart';

class FilterDAO {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final FilterOptions? filterOption;
  final bool? isAscending;

  FilterDAO({
    this.dateFrom,
    this.dateTo,
    this.filterOption,
    this.isAscending,
  });
}
