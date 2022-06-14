// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'published_video_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PublishedVideoStore on _PublishedVideoStoreBase, Store {
  late final _$totalCreditAmountAtom = Atom(
      name: '_PublishedVideoStoreBase.totalCreditAmount', context: context);

  @override
  int? get totalCreditAmount {
    _$totalCreditAmountAtom.reportRead();
    return super.totalCreditAmount;
  }

  @override
  set totalCreditAmount(int? value) {
    _$totalCreditAmountAtom.reportWrite(value, super.totalCreditAmount, () {
      super.totalCreditAmount = value;
    });
  }

  late final _$_PublishedVideoStoreBaseActionController =
      ActionController(name: '_PublishedVideoStoreBase', context: context);

  @override
  int setTotalCreditAmount() {
    final _$actionInfo = _$_PublishedVideoStoreBaseActionController.startAction(
        name: '_PublishedVideoStoreBase.setTotalCreditAmount');
    try {
      return super.setTotalCreditAmount();
    } finally {
      _$_PublishedVideoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalCreditAmount: ${totalCreditAmount}
    ''';
  }
}
