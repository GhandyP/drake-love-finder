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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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

  String _getInterpretationLabel(double probability) {
    if (probability >= 90) {
      return 'Excellent! Outstanding chances';
    } else if (probability >= 75) {
      return 'Very Good! Great potential';
    } else if (probability >= 60) {
      return 'Good! Promising';
    } else if (probability >= 40) {
      return 'Moderate! Keep trying';
    } else if (probability >= 20) {
      return 'Low. Consider improvements';
    } else {
      return 'Very Low. Reflect and try new approaches';
    }
  }

  String? _getPopulationError() {
    final raw = _populationController.text.trim();
    if (raw.isEmpty) return null;
    final normalized = raw.replaceAll(',', '').replaceAll('_', '');
    final int? population = int.tryParse(normalized);
    if (population == null) {
      return 'Please enter a valid number';
    }
    if (population <= 0) {
      return 'Population must be greater than 0';
    }
    return null;
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
              const Text(
                'Your City',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _populationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'City population',
                  hintText: 'e.g. 120000',
                  border: const OutlineInputBorder(),
                  errorText: _getPopulationError(),
                  helperText: 'Enter the population of your city',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              const Text(
                'Your Factors',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 24),
              const Text(
                'Your Results',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Result section with prominent display
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${probability.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getInterpretationLabel(probability),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      estimatedPeople == null
                          ? 'Estimated people in your city: (enter a valid population)'
                          : 'Estimated people in your city: $estimatedPeople',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
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

  String _getLevelLabel(double v) {
    if (v < 0.33) return 'Low';
    if (v < 0.67) return 'Medium';
    return 'High';
  }

  String _getHelperText(String label) {
    switch (label) {
      case 'Demographic compatibility':
        return 'How well do you match your target demographic?';
      case 'Meeting opportunities':
        return 'How often do you meet new people?';
      case 'Emotional connection':
        return 'How easily do you form emotional bonds?';
      case 'Communication effectiveness':
        return 'How well do you communicate in relationships?';
      case 'Long-term compatibility':
        return 'How likely are you to maintain a long-term relationship?';
      case 'Time frame':
        return 'How soon are you looking for a relationship?';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getLevelLabel(value),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Slider(
            value: value,
            min: 0,
            max: 1,
            divisions: 100,
            label: value.toStringAsFixed(2),
            onChanged: onChanged,
          ),
          Text(
            _getHelperText(label),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
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
