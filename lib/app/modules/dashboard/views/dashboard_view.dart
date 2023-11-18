import 'package:Findings/app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Findings/app/custom_widgets/widgets/appBar.dart';
import 'package:Findings/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:Findings/app/custom_widgets/widgets/findings_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'OVERVIEW DASHBOARD',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Spacing.hStandard,
                    const Text(
                      'Stationary',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacing.hStandard,
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(3, 75, 8, 1.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Spacing.hStandard,
                    const Text(
                      'Machinery',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Spacing.vLarge,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  height: 350,
                  child: Obx(() => SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryYAxis: CategoryAxis(
                            isVisible: false,
                          ),
                          primaryXAxis: CategoryAxis(
                              labelsExtent: 100,
                              labelAlignment: LabelAlignment.center,
                              labelRotation: 0,
                              labelIntersectAction: AxisLabelIntersectAction.wrap,
                              majorGridLines: MajorGridLines(width: 0)),
                          series: <ChartSeries>[
                            StackedColumnSeries<ChartData, String>(
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    labelAlignment: ChartDataLabelAlignment.middle,
                                    showCumulativeValues: false,
                                    showZeroValue: false,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                                dataSource: controller.chartData.value,
                                color: Colors.green,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y1),
                            StackedColumnSeries<ChartData, String>(
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    labelAlignment: ChartDataLabelAlignment.middle,
                                    showCumulativeValues: false,
                                    showZeroValue: false,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                                dataSource: controller.chartData.value,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                                color: const Color.fromRGBO(3, 75, 8, 1.0),
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y2),
                          ])),
                ),
                Spacing.vLarge,
                const Text(
                  'Latest Updates',
                  style: TextStyle(fontSize: 28),
                ),
                Spacing.vLarge,
                Obx(
                  () => controller.findings.isEmpty
                      ? const Text(
                          'No Findings',
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                                onTap: () => controller.onTapCard(i),
                                child: FindingsCard(
                                  title: controller.findings[i].title,
                                  description: controller.findings[i].equipmentDescription,
                                  tag: controller.findings[i].equipmentTag,
                                  category: controller.findings[i].category,
                                  area: controller.findings[i].area,
                                  date: controller.findings[i].date,
                                ));
                          },
                          itemCount: controller.findings.length,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
