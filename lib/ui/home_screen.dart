import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:traveloka/core/data/model/all_flight.dart';
import 'package:traveloka/ui/cubit/flight_cubit.dart';
import '../core/utils/status.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_colors.dart';
import '../core/widgets/app_search_bar.dart';
import '../core/widgets/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AllFlight>? listFlight;
  List<AllFlight>? filteredList;
  var isLoading = false;

  @override
  void initState() {
    context.read<FlightCubit>().getFlight();
    isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerList(String value) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: AppColors.softGray),
        child: Text(
          value,
          textAlign: TextAlign.start,
          style: AppTheme()
              .textTheme
              .headline6
              ?.copyWith(color: AppColors.textGray, fontSize: 14.sp),
        ),
      );
    }

    Widget itemList(String name, String location) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:
                      AppTheme().textTheme.headline6?.copyWith(fontSize: 14.sp),
                ),
                Text(
                  location,
                  style: AppTheme().textTheme.subtitle1?.copyWith(
                        color: AppColors.textGray,
                        fontSize: 12.sp,
                      ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
            color: AppColors.softGray,
          )
        ],
      );
    }

    Widget headerSection() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        decoration: const BoxDecoration(color: Colors.blue),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: AppSearchBar(
                  hint: 'Search airports or city name',
                  onChanged: filterList,
                )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: AppButton(
                onPressed: () => exit(0),
                color: Colors.transparent,
                caption: 'CLOSE',
                radius: 8,
                padding: 12.5,
              ),
            ),
          ],
        ),
      );
    }

    Widget listSection() {
      log(listFlight.toString());
      return Expanded(
        child: GroupedListView<AllFlight, String>(
          elements: filteredList!,
          groupBy: (element) => element.countryName!,
          itemComparator: (item1, item2) =>
              item1.airportName!.compareTo(item2.airportName!),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          floatingHeader: false,
          groupSeparatorBuilder: (String value) => headerList(value),
          itemBuilder: (context, element) =>
              itemList(element.airportName!, element.locationName!),
        ),
      );
    }

     Widget notFound() {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.restore_rounded,
              size: 100.0,
              color: AppColors.textBlack,
            ),
            Text(
              "Data not found",
              style: AppTheme()
                  .textTheme
                  .headline6
                  ?.copyWith(color: AppColors.textBlack),
            ),
          ],
        ),
      );
    }

    Widget loading() {
      return Expanded(
        child: Container(
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      );
    }

    return BlocConsumer<FlightCubit, FlightState>(
      listener: (context, state) {
        log(state.toString());
        if (state is GetFlightState) {
          if (state.status == Status.loading) {
            setState(() {
              isLoading = true;
            });
            listFlight = null;
          }
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Success')));
            listFlight = state.data;
            setState(() {
              isLoading = false;
              filteredList = listFlight;
            });
          }
          if (state.status == Status.error) {
            setState(() {
              isLoading = false;
            });
            listFlight = null;
          }
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.blue,
          child: SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  headerSection(),
                  isLoading
                      ? loading()
                      : filteredList == null || filteredList!.isEmpty
                          ? notFound()
                          : listSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void filterList(String query) {
    List<AllFlight> result = [];
    if (query.isEmpty && listFlight == null) {
      result = listFlight!;
    } else {
      result = listFlight!
          .where((flight) =>
              flight.countryName!.toLowerCase().contains(query.toLowerCase()) ||
              flight.airportName!.toLowerCase().contains(query.toLowerCase()) ||
              flight.locationName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredList = result;
    });
  }
}
