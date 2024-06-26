import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_guardian/filter/services/filter_options.dart';

import 'package:shelf_guardian/filter/services/filter_dao.dart';

class FilterService {
  static Future<void> save({
    DateTime? dateFrom,
    DateTime? dateTo,
    FilterOptions? filterOption,
    bool? isAscending,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (dateFrom != null) {
      prefs.setInt('dateFrom', dateFrom.millisecondsSinceEpoch);
    }
    if (dateTo != null) {
      prefs.setInt('dateTo', dateTo.millisecondsSinceEpoch);
    }
    if (filterOption != null) {
      prefs.setString('filterOption', filterOption.toString());
    }
    if (isAscending != null) {
      prefs.setBool('isAscending', isAscending);
    }
  }

  static Future<FilterDAO> load() async {
    final prefs = await SharedPreferences.getInstance();

    final dateFromEpoch = prefs.getInt('dateFrom');
    final dateToEpoch = prefs.getInt('dateTo');
    final filterOptionString = prefs.getString('filterOption');
    final isAscending = prefs.getBool('isAscending');

    return FilterDAO(
      dateFrom: dateFromEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(dateFromEpoch)
          : null,
      dateTo: dateToEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(dateToEpoch)
          : null,
      filterOption: filterOptionString != null
          ? FilterOptions.values
              .firstWhere((e) => e.toString() == filterOptionString)
          : null,
      isAscending: isAscending,
    );
  }

  static void deleteDateFrom() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('dateFrom');
  }

  static void deleteDateTo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('dateTo');
  }
}
