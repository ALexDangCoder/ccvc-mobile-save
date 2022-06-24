import 'dart:developer';

import 'package:flutter/material.dart';

class FormGroup extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  const FormGroup({Key? key, required this.child, this.scrollController})
      : super(key: key);

  @override
  FormGroupState createState() => FormGroupState();
}

class FormGroupState extends State<FormGroup> {
  final Map<GlobalKey<FormState>, bool> _validator = {};

  bool checkValidator() {
    final result = _validator.values.contains(false);
    if (result == true) {
      return false;
    }
    return true;
  }

  bool validator() {
    for (var vl in _validator.keys) {
      _validator[vl] = vl.currentState!.validate();
    }
    final result = _validator.values.contains(false);

    _scrollToError();
    if (result == true) {
      return false;
    }

    return true;
  }

  void _scrollToError() {
    for (final element in _validator.keys) {
      final validator = _validator[element];
      if (validator == true ) {
        // ignore: cast_nullable_to_non_nullable
        final box = element.currentContext?.findRenderObject() as RenderBox;
        final Offset position = box.globalToLocal(Offset.zero);
        if (widget.scrollController != null) {
          widget.scrollController!.animateTo(
             position.dy,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }

        break;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return FormProvider(validator: _validator, child: widget.child);
  }
}

class FormProvider extends InheritedWidget {
  final Map<GlobalKey<FormState>, bool> validator;

  const FormProvider({
    Key? key,
    required this.validator,
    required Widget child,
  }) : super(key: key, child: child);

  static FormProvider? of(BuildContext context) {
    final FormProvider? result =
        context.dependOnInheritedWidgetOfExactType<FormProvider>();
    if (result == null) {
      return null;
    }
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
