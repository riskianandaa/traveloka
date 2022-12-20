part of 'flight_cubit.dart';

abstract class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object?> get props => [];
}

class FlightInitial extends FlightState {}

class GetFlightState extends FlightState {
  final Status status;
  final String? message;
  final List<AllFlight>? data;

  const GetFlightState({required this.status, this.message, this.data});

  @override
  List<Object?> get props => [status, message, data];
}
