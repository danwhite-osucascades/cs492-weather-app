import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast/forecast.dart';
import 'package:weatherapp/widgets/location/location.dart';

class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 500,
      child: TabBarView(
        controller: _tabController,
        children: [
          ForecastWidget(),
          LocationWidget(),
        ],
      ),
    );
  }
}