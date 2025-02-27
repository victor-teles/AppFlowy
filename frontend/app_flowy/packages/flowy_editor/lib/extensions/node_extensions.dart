import 'package:flowy_editor/document/node.dart';
import 'package:flowy_editor/document/selection.dart';
import 'package:flowy_editor/extensions/object_extensions.dart';
import 'package:flowy_editor/extensions/path_extensions.dart';
import 'package:flowy_editor/render/selection/selectable.dart';
import 'package:flutter/material.dart';

extension NodeExtensions on Node {
  RenderBox? get renderBox =>
      key?.currentContext?.findRenderObject()?.unwrapOrNull<RenderBox>();

  BuildContext? get context => key?.currentContext;
  Selectable? get selectable => key?.currentState?.unwrapOrNull<Selectable>();

  bool inSelection(Selection selection) {
    if (selection.start.path <= selection.end.path) {
      return selection.start.path <= path && path <= selection.end.path;
    } else {
      return selection.end.path <= path && path <= selection.start.path;
    }
  }

  Rect get rect {
    if (renderBox != null) {
      final boxOffset = renderBox!.localToGlobal(Offset.zero);
      return boxOffset & renderBox!.size;
    }
    return Rect.zero;
  }
}
