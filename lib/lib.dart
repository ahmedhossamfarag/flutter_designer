import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_designer/base.dart';
import 'control_cupertino.dart';
import 'controls_a.dart';
import 'controls_b.dart';
import 'controls_c.dart';
import 'controls_d.dart';
import 'controls_e.dart';
import 'controls_f.dart';
import 'controls_i.dart';
import 'controls_l.dart';
import 'controls_o.dart';
import 'controls_p.dart';
import 'controls_r.dart';
import 'controls_s.dart';
import 'controls_t.dart';

class Library {
  static Map<Type, Control Function()> controls = {
    Text : () => TextControl(),
    Center : () => CenterControl(),
    ColoredBox : () => ColoredBoxControl(),
    Column : () => ColumnControl(),
    Align : () => AlignControl(),
    Card : () => CardControl(),
    Chip : () => ChipControl(),
    Padding : () => PaddingControl(),
    Row : () => RowControl(),
    Checkbox : () => CheckboxControl(),
    Container : () => ContainerControl(),
    AbsorbPointer : () => AbsorbPointerControl(),
    AlertDialog : () => AlertDialogControl(),
    AnimatedAlign : () => AnimatedAlignControl(),
    Opacity : () => OpacityControl(),
    Draggable : () => DraggableControl(),
    DragTarget : () => DragTargetControl(),
    Expanded : () => ExpandedControl(),
    FloatingActionButton : () => FloatingActionButtonControl(),
    Icon : () => IconControl(),
    SizedBox : () => SizedBoxControl(),
    Radio : () => RadioControl(),
    IconButton : () => IconButtonControl(),
    Stack : () => StackControl(),
    Switch : () => SwitchControl(),
    TextButton : () => TextButtonControl(),
    LongPressDraggable : () => LongPressDraggableControl(),
    TextField : () => TextFieldControl(),
    AnimatedContainer : () => AnimatedContainerControl(),
    AnimatedCrossFade : () => AnimatedCrossFadeControl(),
    AnimatedDefaultTextStyle : () => AnimatedDefaultTextStyleControl(),
    AnimatedOpacity : () => AnimatedOpacityControl(),
    AnimatedPositioned : () => AnimatedPositionedControl(),
    AnimatedSize : () => AnimatedSizeControl(),
    AppBar : () => AppBarControl(),
    AspectRatio : () => AspectRatioControl(),
    BottomSheet : () => BottomSheetControl(),
    BottomNavigationBar : () => BottomNavigationBarControl(),
    CircularProgressIndicator : () => CircularProgressIndicatorControl(),
    ClipOval : () => ClipOvalControl(),
    CupertinoActionSheet : () => CupertinoActionSheetControl(),
    CupertinoActivityIndicator : () => CupertinoActivityIndicatorControl(),
    CupertinoAlertDialog : () => CupertinoAlertDialogControl(),
    CupertinoButton : () => CupertinoButtonControl(),
    CupertinoContextMenu : () => CupertinoContextMenuControl(),
    CupertinoDatePicker : () => CupertinoDatePickerControl(),
  };
}