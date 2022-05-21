import 'package:equatable/equatable.dart';

class Currency with EquatableMixin {
  const Currency({required this.name});
  const Currency.empty() : name = 'empty';

  final String name;

  @override
  List<Object?> get props => [name];

  @override
  String toString() => name;
}
