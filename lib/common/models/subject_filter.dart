import 'package:flutter/foundation.dart';

@immutable
class SubjectFilter {
  final String ecoleId;
  final String niveauId;

  const SubjectFilter({required this.ecoleId, required this.niveauId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectFilter &&
          runtimeType == other.runtimeType &&
          ecoleId == other.ecoleId &&
          niveauId == other.niveauId;

  @override
  int get hashCode => ecoleId.hashCode ^ niveauId.hashCode;

  @override
  String toString() => 'SubjectFilter(ecoleId: $ecoleId, niveauId: $niveauId)';
}
