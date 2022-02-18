import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:flutter/material.dart';

class OutgoingDocumentProvider extends InheritedWidget {
  final OutgoingDocumentCubit outGoingCubit;

  const OutgoingDocumentProvider({
    Key? key,
    required this.outGoingCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static OutgoingDocumentProvider of(BuildContext context) {
    final OutgoingDocumentProvider? result =
    context.dependOnInheritedWidgetOfExactType<OutgoingDocumentProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}