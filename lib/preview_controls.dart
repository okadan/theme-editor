import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/constants.dart' as constants;

class ControlsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RadioPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _CheckboxPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _SwitchPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _SliderPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _ProgressIndicatorPreview(),
      ],
    );
  }
}

class _RadioPreview extends StatelessWidget {
  Widget _buildRadio(bool value, ValueChanged<bool?>? onChanged) {
    return Expanded(
      child: Align(
        child: Radio(
          groupValue: true,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRadio(true, (_) {}),
        _buildRadio(false, (_) {}),
        _buildRadio(true, null),
        _buildRadio(false, null),
      ],
    );
  }
}

class _CheckboxPreview extends StatelessWidget {
  Widget _buildCheckbox(bool value, ValueChanged<bool?>? onChanged) {
    return Expanded(
      child: Align(
        child: Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCheckbox(true, (_) {}),
        _buildCheckbox(false, (_) {}),
        _buildCheckbox(true, null),
        _buildCheckbox(false, null),
      ],
    );
  }
}

class _SwitchPreview extends StatelessWidget {
  Widget _buildSwitch(bool value, ValueChanged<bool?>? onChanged) {
    return Expanded(
      child: Align(
        child: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSwitch(true, (_) {}),
        _buildSwitch(false, (_) {}),
        _buildSwitch(true, null),
        _buildSwitch(false, null),
      ],
    );
  }
}

class _SliderPreview extends StatelessWidget {
  Widget _buildSlider(double value, ValueChanged<double>? onChanged, [int? divisions]) {
    return Expanded(
      child: Align(
        child: Slider(
          divisions: divisions,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildSlider(0.5, (_) {}),
            _buildSlider(0.5, null),
          ],
        ),
        SizedBox(height: constants.previewLayoutGap),
        Row(
          children: [
            _buildSlider(0.5, (_) {}, 6),
            _buildSlider(0.5, null, 6),
          ],
        ),
      ],
    );
  }
}

class _ProgressIndicatorPreview extends StatelessWidget {
  Widget _buildIndicator(Widget indicator) {
    return Expanded(
      child: Align(
        child: indicator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIndicator(LinearProgressIndicator(value: 0.5)),
        _buildIndicator(CircularProgressIndicator(value: 0.5)),
      ],
    );
  }
}
