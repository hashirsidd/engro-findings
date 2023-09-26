import 'package:flutter/material.dart';
import 'package:Findings/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:Findings/app/utils/spacing.dart';

class CustomStackedColumnChart extends StatelessWidget {
  final double barWidth;
  final DashboardController controller;

  const CustomStackedColumnChart({
    Key? key,
    this.barWidth = 30.0,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 220.0,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _BackgroundLines(),
                          _BackgroundLines(),
                          _BackgroundLines(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: _buildBars(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacing.vMedium,
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildLabels(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            controller.max.value.toString(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Positioned(
          top: 92,
          left: 0,
          child: Text(
            (controller.max.value ~/ 2).toString(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const Positioned(
          bottom: 28,
          left: 0,
          child: Text(
            '0',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBars() {
    List<Widget> bars = [];
    controller.graph.forEach((key, values) {
      bars.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: controller.max.value - (values[1] + values[0]),
              child: Container(
                width: barWidth,
                color: Colors.transparent,
              ),
            ),
            Expanded(
              flex: values[1] + values[0],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Expanded(
                      flex: values[1],
                      child: Container(
                        width: barWidth,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            values[1].toString(),
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: values[0],
                      child: Container(
                        width: barWidth,
                        color: const Color.fromRGBO(3, 75, 8, 1.0),
                        // Change color as needed
                        child: Center(
                          child: Text(
                            values[0].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
    return bars;
  }

  List<Widget> _buildLabels() {
    List<Widget> bars = [];
    controller.graph.forEach((key, values) {
      bars.add(
        SizedBox(
          width: barWidth,
          child: Text(
            key.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
    return bars;
  }
}

class _BackgroundLines extends StatelessWidget {
  const _BackgroundLines({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey[400],
      margin: const EdgeInsets.only(left: 25),
    );
  }
}
