import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:flutter/material.dart';

class InComingDocumentProvider extends InheritedWidget {
  final IncomingDocumentCubit outGoingCubit;

  const InComingDocumentProvider({
    Key? key,
    required this.outGoingCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static InComingDocumentProvider of(BuildContext context) {
    final InComingDocumentProvider? result =
        context.dependOnInheritedWidgetOfExactType<InComingDocumentProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
