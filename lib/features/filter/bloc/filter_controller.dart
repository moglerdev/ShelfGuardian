import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shelf_guardian/service/filter_service.dart';

/// The abstract class representing the contract for a filter controller.
abstract class FilterController {
  /// Saves the current filter settings.
  void saveFilter();

  /// Deletes the filter settings.
  void deleteFilter();

  /// Returns whether the sort order is ascending or not.
  bool isAscending();

  /// Updates the selected filter option.
  void updateFilterOption(FilterOptions value);

  /// Returns the currently selected filter option.
  FilterOptions getSelectedFilter();

  /// Toggles the sort order between ascending and descending.
  void toggleSortOrder();

  /// Updates the start date of the filter.
  void updateDateFrom(DateTime value);

  /// Returns the start date of the filter.
  DateTime? getDateFrom();

  /// Updates the end date of the filter.
  void updateDateTo(DateTime value);

  /// Returns the end date of the filter.
  DateTime? getDateTo();
}

/// The implementation of the [FilterController] using the [Cubit] from the Flutter Bloc library.
class FilterControllerCubit extends Cubit<FilterDAO>
    implements FilterController {
  final filterService = FilterService.create();

  /// Creates a new instance of [FilterControllerCubit].
  FilterControllerCubit()
      : super(FilterDAO(
            dateFrom: DateTime.now(),
            dateTo: DateTime.now(),
            filterOption: FilterOptions.expired_at,
            isAscending: false)) {
    unawaited(init());
  }

  /// Initializes the filter controller by loading the filter data from the service.
  Future<void> init() async {
    final filterData = await filterService.load();

    emit(FilterDAO(
      dateFrom: filterData.dateFrom,
      dateTo: filterData.dateTo,
      filterOption: filterData.filterOption ?? FilterOptions.expired_at,
      isAscending: filterData.isAscending ?? false,
    ));
  }

  @override
  void saveFilter() {
    filterService.save(FilterDAO(
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      filterOption: state.filterOption,
      isAscending: state.isAscending,
    ));
  }

  @override
  void deleteFilter() {
    emit(FilterDAO(
      dateFrom: null,
      dateTo: null,
      filterOption: FilterOptions.expired_at,
      isAscending: false,
    ));
    filterService.deleteDateFrom();
    filterService.deleteDateTo();
    saveFilter();
  }

  @override
  bool isAscending() {
    return state.isAscending!;
  }

  @override
  void updateFilterOption(FilterOptions value) {
    emit(FilterDAO(
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      filterOption: value,
      isAscending: state.isAscending,
    ));
  }

  @override
  FilterOptions getSelectedFilter() {
    return state.filterOption!;
  }

  @override
  void toggleSortOrder() {
    emit(FilterDAO(
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      filterOption: state.filterOption,
      isAscending: !state.isAscending!,
    ));
  }

  @override
  void updateDateFrom(DateTime value) {
    emit(FilterDAO(
      dateFrom: value,
      dateTo: state.dateTo,
      filterOption: state.filterOption,
      isAscending: state.isAscending,
    ));
  }

  @override
  DateTime? getDateFrom() {
    return state.dateFrom;
  }

  @override
  void updateDateTo(DateTime value) {
    emit(FilterDAO(
      dateFrom: state.dateFrom,
      dateTo: value,
      filterOption: state.filterOption,
      isAscending: state.isAscending,
    ));
  }

  @override
  DateTime? getDateTo() {
    return state.dateTo;
  }
}
