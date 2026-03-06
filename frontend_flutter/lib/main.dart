import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const DrakeLoveFinderApp());
}

class DrakeLoveFinderApp extends StatelessWidget {
  const DrakeLoveFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drake Equation Love Finder',
      theme: ThemeData(useMaterial3: true),
      home: const LoveFinderHomePage(),
    );
  }
}

class LoveFinderHomePage extends StatefulWidget {
  const LoveFinderHomePage({super.key});

  @override
  State<LoveFinderHomePage> createState() => _LoveFinderHomePageState();
}

class _LoveFinderHomePageState extends State<LoveFinderHomePage> {
  final TextEditingController _populationController = TextEditingController();

  final List<_Factor> _factors = <_Factor>[
    _Factor('Demographic compatibility', 0.5),
    _Factor('Meeting opportunities', 0.5),
    _Factor('Emotional connection', 0.5),
    _Factor('Communication effectiveness', 0.5),
    _Factor('Long-term compatibility', 0.5),
    _Factor('Time frame', 0.5),
  ];

  int? _parsePopulation() {
    final String raw = _populationController.text.trim();
    if (raw.isEmpty) return null;
    final String normalized = raw.replaceAll(',', '').replaceAll('_', '');
    final int? population = int.tryParse(normalized);
    if (population == null || population <= 0) return null;
    return population;
  }

  double _probabilityPercent() {
    double p = 1.0;
    for (final _Factor f in _factors) {
      p *= f.value;
    }
    return min(p * 100.0, 100.0);
  }

  @override
  void dispose() {
    _populationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int? population = _parsePopulation();
    final double probability = _probabilityPercent();
    final int? estimatedPeople = population == null
        ? null
        : (population * (probability / 100.0)).floor();

    return Scaffold(
      appBar: AppBar(title: const Text('Drake Equation Love Finder')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _populationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'City population',
                  hintText: 'e.g. 120000',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < _factors.length; i++)
                _FactorSlider(
                  label: _factors[i].label,
                  value: _factors[i].value,
                  onChanged: (double v) {
                    setState(() {
                      _factors[i] = _factors[i].copyWith(value: v);
                    });
                  },
                ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Love probability: ${probability.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        estimatedPeople == null
                            ? 'Estimated people in your city: (enter a valid population)'
                            : 'Estimated people in your city: $estimatedPeople',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FactorSlider extends StatelessWidget {
  const _FactorSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('$label: ${value.toStringAsFixed(2)}'),
        Slider(
          value: value,
          min: 0,
          max: 1,
          divisions: 100,
          label: value.toStringAsFixed(2),
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _Factor {
  const _Factor(this.label, this.value);

  final String label;
  final double value;

  _Factor copyWith({String? label, double? value}) {
    return _Factor(label ?? this.label, value ?? this.value);
  }
}
