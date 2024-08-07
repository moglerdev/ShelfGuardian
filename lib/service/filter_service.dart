// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

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

enum FilterOptions {
  expired_at('Mindesthaltbarkeitsdatum'),
  name('Name'),
  created_at('Erstellt am'),
  price_in_cents('Preis');

  const FilterOptions(this.label);

  final String label;
}

abstract class FilterService {
  Future<void> save(FilterDAO filterData);

  Future<FilterDAO> load();

  void deleteDateFrom();

  void deleteDateTo();

  static FilterService create() {
    return FilterServiceImpl();
  }
}

class FilterServiceImpl implements FilterService {
  @override
  Future<void> save(FilterDAO filterData) async {
    final prefs = await SharedPreferences.getInstance();

    if (filterData.dateFrom != null) {
      prefs.setInt('dateFrom', filterData.dateFrom!.millisecondsSinceEpoch);
    }
    if (filterData.dateTo != null) {
      prefs.setInt('dateTo', filterData.dateTo!.millisecondsSinceEpoch);
    }
    if (filterData.filterOption != null) {
      prefs.setString('filterOption', filterData.filterOption!.toString());
    }
    if (filterData.isAscending != null) {
      prefs.setBool('isAscending', filterData.isAscending!);
    }
  }

  @override
  Future<FilterDAO> load() async {
    final prefs = await SharedPreferences.getInstance();

    final dateFromEpoch = prefs.getInt('dateFrom');
    final dateToEpoch = prefs.getInt('dateTo');
    final filterOptionString = prefs.getString('filterOption');
    final isAscending = prefs.getBool('isAscending');
    final filterOption = FilterOptions.values
        .where((e) => e.toString() == filterOptionString)
        .firstOrNull;

    return FilterDAO(
      dateFrom: dateFromEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(dateFromEpoch)
          : null,
      dateTo: dateToEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(dateToEpoch)
          : null,
      filterOption: filterOption != null || filterOptionString != null
          ? filterOption
          : null,
      isAscending: isAscending,
    );
  }

  @override
  void deleteDateFrom() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('dateFrom');
  }

  @override
  void deleteDateTo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('dateTo');
  }
}
