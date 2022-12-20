import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:traveloka/core/data/datasource/api/flight_api.dart';
import 'package:traveloka/di/injection.dart';
import '../../core/data/model/all_flight.dart';
import '../../core/utils/status.dart';
import 'dart:developer' as developer;

part 'flight_state.dart';

@injectable
class FlightCubit extends Cubit<FlightState> {
  FlightCubit(this._api) : super(FlightInitial());

  final FLightApi _api;

  void getFlight() async {
    emit(const GetFlightState(status: Status.loading));
    try {
      final response = await _api.getFlights();
      emit(GetFlightState(status: Status.success, data: response.data));
    } catch (e) {
      developer.log(e.toString());
      emit(GetFlightState(status: Status.error, message: e.toString()));
    }
  }
}
