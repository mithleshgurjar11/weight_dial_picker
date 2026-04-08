library weight_dial_picker;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weight_dial_picker/src/dial_painter.dart';


class WeightDialPicker extends StatefulWidget {
  final double minWeight;
  final double maxWeight;
  final String unit;
  final void Function(double value, String unit) onChanged;
  final double? initialWeight;

  const WeightDialPicker({
    super.key,
    this.minWeight = 20,
    this.maxWeight = 200,
    this.unit = 'kg',
    required this.onChanged,
     this.initialWeight,
  });

  @override
  State<WeightDialPicker> createState() => _WeightDialPickerState();
}

class _WeightDialPickerState extends State<WeightDialPicker> {
  int currentStep = 2;
  String _selectedUnit = 'lb';

  double angle = 0;
  final int baseMinWeightKg = 20;
  final int baseMaxWeightKg = 200;

  int get selectedWeight {
    final progress = angle / pi;
    final kgValue = baseMinWeightKg + (baseMaxWeightKg - baseMinWeightKg) * progress;
    return _selectedUnit == 'kg'
        ? kgValue.round()
        : (kgValue * 2.20462).round();
  }

  int get minWeight => _selectedUnit == 'kg'
      ? baseMinWeightKg
      : (baseMinWeightKg * 2.20462).round();

  int get maxWeight => _selectedUnit == 'kg'
      ? baseMaxWeightKg
      : (baseMaxWeightKg * 2.20462).round();


  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      angle += details.delta.dx * 0.01;
      angle = angle.clamp(0.0, pi);
    });

    widget.onChanged(
      selectedWeight.toDouble(),
      _selectedUnit,
    );
  }

  @override
  void initState() {
    _selectedUnit = widget.unit;

    if (widget.initialWeight != null) {
      double kgValue = widget.unit == 'kg'
          ? widget.initialWeight!
          : widget.initialWeight! / 2.20462;

      final progress =
          (kgValue - baseMinWeightKg) / (baseMaxWeightKg - baseMinWeightKg);

      angle = (progress * pi).clamp(0.0, pi);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUnitToggle(),
            const SizedBox(height: 20),
            _buildWeightDisplay(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: StaticDialWithRotatingPointer(
                angle: angle,
                min: minWeight,
                max: maxWeight,
                unit: _selectedUnit,
              ),
              size: const Size(double.infinity, 300),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 35,
        //   child: CircularProgressButton(
        //     totalSteps: 5,
        //     currentStep: currentStep,
        //     onTap: goToNextStep,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildWeightDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF77B46),
            Color(0xFFDE7D55),
            Color(0xFF797898),
            Color(0xFF5F77A9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "$selectedWeight$_selectedUnit",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildUnitToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['kg', 'lb'].map((unit) {
        final isSelected = _selectedUnit == unit;
        return GestureDetector(
          onTap: () => setState(() => _selectedUnit = unit),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 27),
            decoration: BoxDecoration(
              color: isSelected ? null : Colors.white,
              gradient: isSelected
                  ? const LinearGradient(
                colors: [
                  Color(0xFFFD6E4C),
                  Color(0xFFF57E46),
                  Color(0xFF76789A),
                  Color(0xFF5977AD),
                ],
              )
                  : null,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              unit,
              style: TextStyle(
                color: isSelected ? Colors.white: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
