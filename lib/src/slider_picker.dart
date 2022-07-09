import 'package:flutter/material.dart';

abstract class SliderPickerAdaptor<T> {
  const SliderPickerAdaptor();

  double toDouble(T value);
  String toText(T value);
  T fromDouble(double value);
  String toTextFromDouble(double value) => toText(fromDouble(value));
}

class SliderPicker<T> extends StatefulWidget {
  const SliderPicker({
    required this.min,
    required this.max,
    required this.onChanged,
    required this.adaptor,
    Key? key,
    this.initValue,
    this.decoration,
    this.divisions,
  }) : super(key: key);

  final int? divisions;
  final T? initValue;
  final T min, max;
  final void Function(T value) onChanged;
  final SliderPickerAdaptor<T> adaptor;

  final InputDecoration? decoration;

  @override
  _SliderPickerState createState() => _SliderPickerState<T>();
}

class _SliderPickerState<T> extends State<SliderPicker<T>> {
  late final double min, max;
  late final String minText, maxText;
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.adaptor.toDouble(widget.initValue ?? widget.min);
    min = widget.adaptor.toDouble(widget.min);
    max = widget.adaptor.toDouble(widget.max);
    minText = widget.adaptor.toText(widget.min);
    maxText = widget.adaptor.toText(widget.max);
  }

  @override
  void didUpdateWidget(covariant SliderPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      value = widget.adaptor.toDouble(widget.initValue ?? widget.min);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: widget.decoration ?? const InputDecoration(),
        // isHovering: false,
        child: Column(
          children: [
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: widget.divisions,
              onChanged: (double val) {
                setState(() {
                  value = val;
                  widget.onChanged(widget.adaptor.fromDouble(value));
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(minText),
                Text(widget.adaptor.toTextFromDouble(value)),
                Text(maxText),
              ],
            )
          ],
        ));
  }
}
