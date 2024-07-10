import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_guardian/filter/services/filter_options.dart';

import 'package:shelf_guardian/filter/services/filter_dao.dart';

class FilterService {
  static Future<void> save(FilterDAO filterData) async {

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
