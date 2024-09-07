import 'package:flutter/material.dart';
import 'package:niko_driweather/utils/color_palette.dart';
import 'package:niko_driweather/utils/constant.dart';
import 'daily_details.dart';
import 'hourly_details.dart';
import 'month_picker.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: ColorPalette.shadow,
                                offset: Offset(-3, 3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: ColorPalette.shadow,
                              offset: Offset(-3, 3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formattedDateShort,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: ColorPalette.shadow,
                              offset: Offset(-3, 3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) => HourlyDetails(index: index)),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: ColorPalette.shadow,
                              offset: Offset(-3, 3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return MonthPickerBottomSheet(
                                  onMonthSelected: (DateTime selectedMonth) {
                                    // Handle the selected month here
                                    print("Selected month: ${selectedMonth.month}");
                                  },
                                  initialDate: DateTime.now(),
                                );
                              },
                            );
                          },
                          child: Image(
                              image:
                                  const AssetImage('assets/img/calendar.png'),
                              width: 24),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 60.0 * 7,
                    child: RawScrollbar(
                      thumbColor: Colors.white,
                      trackColor: Colors.white.withOpacity(0.2),
                      trackBorderColor: Colors.white.withOpacity(0.2),
                      trackRadius: Radius.circular(10),
                      thumbVisibility: true,
                      thickness: 8,
                      radius: Radius.circular(10),
                      trackVisibility: true,
                      interactive: true,
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 6, 30, 6),
                            child: DailyDetails(),
                          );
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        const AssetImage('assets/img/sun.png'),
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'DRI Weather',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: ColorPalette.shadow,
                              offset: Offset(-3, 3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
