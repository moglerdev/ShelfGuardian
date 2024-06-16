import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScannerState {}

class ScannerScanning extends ScannerState {}

class ScannerControllerCubit extends Cubit<ScannerState> {
  ScannerControllerCubit() : super(ScannerScanning());
}
