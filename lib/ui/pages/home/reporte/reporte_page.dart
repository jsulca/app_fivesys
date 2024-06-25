import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:app_fivesys/domain/models/reporte.dart';
import 'package:app_fivesys/helpers/util.dart';
import 'package:app_fivesys/ui/pages/home/home_controller.dart';

class ReportePage extends StatefulWidget {
  const ReportePage({Key? key}) : super(key: key);

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    homeController.getReporte();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Row(
                  children: [
                    Image.asset("assets/image/logo.png"),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Obx(() => (homeController.cargandoReporte.value)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (avisos.isNotEmpty)
                        _showGraphAviso(
                          size: size,
                          avisos: avisos,
                          darkTheme: homeController.darkTheme.value,
                        )
                      else
                        const Center(child: Text('No hay datos')),
                    ],
                  )
                : const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  Widget _showGraphAviso({
    required double size,
    required List<Reporte> avisos,
    required bool darkTheme,
  }) {
    final Map<String, double> dataMap = {};
    final List<Color> colorList = [];
    for (final a in avisos) {
      dataMap.putIfAbsent(a.estado,
          () => (a.cantidad.toDouble() == 0.0) ? 3.0 : a.cantidad.toDouble());
      colorList.add(colorConvert(a.color));
    }

    return SizedBox(
      height: size * 0.35,
      child: PieChart(
        centerText: "AVISO",
        dataMap: dataMap,
        colorList: colorList,
        ringStrokeWidth: 48,
        chartType: ChartType.ring,
        animationDuration: const Duration(milliseconds: 800),
        legendOptions: LegendOptions(
          legendShape: BoxShape.rectangle,
          showLegendsInRow: true,
          legendPosition: LegendPosition.bottom,
          legendTextStyle: TextStyle(
            fontSize: 11,
            color: darkTheme ? kWhiteColor : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        /*   chartValuesOptions: const ChartValuesOptions(
          showChartValuesInPercentage: true,
        ), */
      ),
    );
  }
}
