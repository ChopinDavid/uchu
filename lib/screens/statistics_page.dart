import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uchu/extensions/gender_extension.dart';
import 'package:uchu/extensions/iterable_extension.dart';
import 'package:uchu/models/gender.dart';
import 'package:uchu/models/word_form_type.dart';
import 'package:uchu/services/statistics_service.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Duration? selectedDuration;

  void _onDurationChanged(Duration? duration) {
    setState(() {
      selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> passRates = {};
    final statisticsService = GetIt.instance.get<StatisticsService>();
    final statisticsFutures = <Future<void>>[];

    final exerciseNames = [
      ...WordFormType.values.map(
        (e) => (e.name, e.displayName),
      ),
      ...Gender.values.map(
        (e) => (e.name, '${e.displayString} Nouns'),
      ),
    ];

    for (var element in exerciseNames) {
      statisticsFutures.add(() async {
        final passRate = await statisticsService.getExercisePassRate(
            element.$1, selectedDuration);
        if (passRate != null) {
          passRates[element.$2] = passRate;
        }
      }());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.wait(statisticsFutures),
          builder: (context, snapshot) {
            return passRates.isEmpty &&
                    snapshot.connectionState != ConnectionState.waiting
                ? const Text('Complete exercises to view your statistics.')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _DurationRadioButton(
                                text: 'All',
                                duration: null,
                                selectedDuration: selectedDuration,
                                onChanged: _onDurationChanged,
                              ),
                              _DurationRadioButton(
                                text: 'Day',
                                duration: const Duration(days: 1),
                                selectedDuration: selectedDuration,
                                onChanged: _onDurationChanged,
                              ),
                              _DurationRadioButton(
                                text: 'Week',
                                duration: const Duration(days: 7),
                                selectedDuration: selectedDuration,
                                onChanged: _onDurationChanged,
                              ),
                              _DurationRadioButton(
                                text: 'Month',
                                duration: const Duration(days: 31),
                                selectedDuration: selectedDuration,
                                onChanged: _onDurationChanged,
                              ),
                              _DurationRadioButton(
                                text: 'Year',
                                duration: const Duration(days: 365),
                                selectedDuration: selectedDuration,
                                onChanged: _onDurationChanged,
                              ),
                            ]
                                .intersperse(
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Flexible(
                              child: Column(
                                children: [
                                  Spacer(),
                                  Center(child: CircularProgressIndicator()),
                                  Spacer()
                                ],
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: passRates.length,
                                itemBuilder: (context, index) {
                                  final sortedPassRateEntries = passRates
                                      .entries
                                      .toList()
                                    ..sort(
                                      (a, b) =>
                                          (a.value > b.value) == true ? 1 : 0,
                                    );
                                  final key = sortedPassRateEntries[index].key;
                                  final value =
                                      sortedPassRateEntries[index].value;
                                  return ListTile(
                                    title: Text(key),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PassRateBar(
                                            passRate: value,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                              '${(value * 100).toStringAsFixed(2)}% pass rate'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class PassRateBar extends StatelessWidget {
  final double passRate;

  const PassRateBar({super.key, required this.passRate})
      : assert(passRate >= 0.0 && passRate <= 1.0,
            'Pass rate must be between 0.0 and 1.0');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Expanded(
            flex: (passRate * 100).toInt(),
            child: Container(
              height: 12,
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: ((1 - passRate) * 100).toInt(),
            child: Container(
              height: 12,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationRadioButton extends StatelessWidget {
  const _DurationRadioButton({
    super.key,
    required this.text,
    required this.duration,
    required this.selectedDuration,
    required this.onChanged,
  });
  final String text;
  final Duration? duration;
  final Duration? selectedDuration;
  final void Function(Duration?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 8.0,
          bottom: 8.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text),
            IgnorePointer(
              child: Radio<Duration?>(
                value: duration,
                groupValue: selectedDuration,
                onChanged: (_) {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 0.0,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
      onTap: () => onChanged(duration),
    );
  }
}
