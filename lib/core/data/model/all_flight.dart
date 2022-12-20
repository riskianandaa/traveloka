import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part '../../../gen/core/data/model/all_flight.g.dart';


@JsonSerializable()
class AllFlight extends Equatable {
  @JsonKey(name: 'airport_name')
  final String? airportName;
  @JsonKey(name: 'business_id')
  final String? businessId;
  @JsonKey(name: 'airport_code')
  final String? airportCode;
  @JsonKey(name: 'business_name_trans_id')
  final String? businessNameTransId;
  @JsonKey(name: 'location_name')
  final String? locationName;
  @JsonKey(name: 'country_id')
  final String? countryId;
  @JsonKey(name: 'country_name')
  final String? countryName;
  final String? label;

  const AllFlight({
    this.airportName,
    this.businessId,
    this.airportCode,
    this.businessNameTransId,
    this.locationName,
    this.countryId,
    this.countryName,
    this.label,
  });


  factory AllFlight.fromJson(Map<String, dynamic> json) {
    return _$AllFlightFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllFlightToJson(this);

  @override
  List<Object?> get props {
    return [
      airportName,
      businessId,
      airportCode,
      businessNameTransId,
      locationName,
      countryId,
      countryName,
      label,
    ];
  }
}
