import 'package:flutter/material.dart';

class DropdownTextField<T> extends StatelessWidget {
  const DropdownTextField({
    required this.values,
    required this.currentValue,
    required this.child,
    Key? key,
    this.decoration,
    this.enabled,
    this.autofocus,
    this.onChanged,
    this.isDivided = true,
  }) : super(key: key);

  final List<T> values;
  final T currentValue;
  final void Function(T? value)? onChanged;

  final InputDecoration? decoration;
  final bool? enabled;
  final bool? autofocus;

  final Widget child;
  final bool isDivided;

  @override
  Widget build(BuildContext context) {
    return _decorationWrapper(
      child: Row(
        children: [
          Expanded(
            child: child,
          ),
          if (isDivided)
            const SizedBox(
              height: 20,
              child: VerticalDivider(thickness: 1),
            ),
          SizedBox(
            width: 100,
            child: DropdownButtonFormField<T>(
              decoration: decoration == null
                  ? null
                  : const InputDecoration.collapsed(hintText: null),
              value: currentValue,
              items: values
                  .map(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(e.toString()),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _decorationWrapper({required Widget child}) {
    final wrapDecoration = decoration;
    if (wrapDecoration == null) {
      return child;
    } else {
      return InputDecorator(
        decoration: wrapDecoration,
        child: child,
      );
    }
  }
}
