import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shelf_guardian/filter/services/filter_options.dart';
import 'package:shelf_guardian/filter/services/filter_dao.dart';
import 'package:shelf_guardian/filter/services/filter_service.dart';

abstract class FilterController {
  void saveFilter();
  void deleteFilter();
  bool isAscending();
  void updateFilterOption(FilterOptions value);
  FilterOptions getSelectedFilter();
  void toggleSortOrder();
  void updateDateFrom(DateTime value);
  DateTime? getDateFrom();
  void updateDateTo(DateTime value);
  DateTime? getDateTo();
}

class FilterControllerCubit extends Cubit<FilterDAO>
    implements FilterController {

  final filterService = FilterService.create();
  FilterControllerCubit()
      : super(FilterDAO(
            dateFrom: DateTime.now(),
            dateTo: DateTime.now(),
            filterOption: FilterOptions.bestBeforeDate,
            isAscending: false)) {
    unawaited(init());
  }

  Future<void> init() async {
    final filterData = await filterService.load();

    emit(FilterDAO(
      dateFrom: filterData.dateFrom,
      dateTo: filterData.dateTo,
      filterOption: filterData.filterOption ?? FilterOptions.bestBeforeDate,
      isAscending: filterData.isAscending ?? false,
    ));
  }

  @override
  void saveFilter() {
    filterService.save(
      FilterDAO(
      dateFrom: state.dateFrom,
      dateTo: state.dateTo,
      filterOption: state.filterOption,
      isAscending: state.isAscending,
      ));
    // Todo: add a toast message to confirm the filter has been saved
  }

  @override
  void deleteFilter() {
    emit(FilterDAO(
      dateFrom: null,
      dateTo: null,
      filterOption: FilterOptions.bestBeforeDate,
      isAscending: false,
    ));
    filterService.deleteDateFrom();
    filterService.deleteDateTo();
    saveFilter();
    // Todo: add a toast message to confirm the filter has been deleted
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
