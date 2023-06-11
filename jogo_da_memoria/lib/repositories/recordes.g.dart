// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordesRepository on RecordesRepositoryBase, Store {
  late final _$recordesBrogoAtom =
      Atom(name: 'RecordesRepositoryBase.recordesBrogo', context: context);

  @override
  Map<dynamic, dynamic> get recordesBrogo {
    _$recordesBrogoAtom.reportRead();
    return super.recordesBrogo;
  }

  @override
  set recordesBrogo(Map<dynamic, dynamic> value) {
    _$recordesBrogoAtom.reportWrite(value, super.recordesBrogo, () {
      super.recordesBrogo = value;
    });
  }

  late final _$recordesNormalAtom =
      Atom(name: 'RecordesRepositoryBase.recordesNormal', context: context);

  @override
  Map<dynamic, dynamic> get recordesNormal {
    _$recordesNormalAtom.reportRead();
    return super.recordesNormal;
  }

  @override
  set recordesNormal(Map<dynamic, dynamic> value) {
    _$recordesNormalAtom.reportWrite(value, super.recordesNormal, () {
      super.recordesNormal = value;
    });
  }

  late final _$RecordesRepositoryBaseActionController =
      ActionController(name: 'RecordesRepositoryBase', context: context);

  @override
  dynamic loadRecordes() {
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction(
        name: 'RecordesRepositoryBase.loadRecordes');
    try {
      return super.loadRecordes();
    } finally {
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recordesBrogo: ${recordesBrogo},
recordesNormal: ${recordesNormal}
    ''';
  }
}
