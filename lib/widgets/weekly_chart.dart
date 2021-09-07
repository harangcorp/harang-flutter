import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

BarChart WeeklyChart() {
  return BarChart(
    BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: barGroups,
      gridData: FlGridData(show: false),
      alignment: BarChartAlignment.spaceAround,
      maxY: 20,
    ),
  );
}

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: const EdgeInsets.all(0),
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return null;
        },
      ),
    );

FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xffF8C0FC),
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        margin: 0,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return '월';
            case 1:
              return '화';
            case 2:
              return '수';
            case 3:
              return '목';
            case 4:
              return '금';
            case 5:
              return '토';
            case 6:
              return '일';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );

FlBorderData get borderData => FlBorderData(
      show: false,
    );

BarChartRodData y_data(double y) {
  return BarChartRodData(
    y: y,
    colors: [Color(0xffF8C0FC)],
    backDrawRodData: BackgroundBarChartRodData(
      show: true,
      y: 20,
      colors: [Color(0xffDEE2E6)],
    ),
  );
}

List<BarChartGroupData> get barGroups => [
      BarChartGroupData(
        x: 0,
        barRods: [y_data(8)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [y_data(10)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [y_data(14)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [y_data(15)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [y_data(10)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [y_data(10)],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [y_data(10)],
        showingTooltipIndicators: [0],
      ),
    ];
