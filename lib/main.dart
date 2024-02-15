
import 'package:flutter/material.dart';
/*
import 'package:flutter_designer/display.dart';
import 'controls_a.dart';
import 'controls_b.dart';
import 'controls_c.dart';
import 'controls_i.dart';
import 'controls_p.dart';
import 'controls_r.dart';
import 'controls_s.dart';
import 'controls_t.dart';
 */

import 'designer.dart';

void main() => runApp(const MaterialApp(
  home: Designer(),
));

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var expand = List.filled(26, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                width: 200,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.white70
                  ),
                  child: Column(
                    children: [
                      ExpansionPanelList(
                        expansionCallback: (i, b) => setState(() { expand[i] = !b; }),
                        children: [
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('A'),
                              isExpanded: expand[0],
                              body: Column(
                                children: [
                                  ControlAdder('Absorb Pointer' , (parent) => AbsorbPointerControl(key: Key('absorb_pointer${++_counter}'), parent : parent)),
                                  ControlAdder('Alert Dialog', (parent)=> AlertDialogControl(key: Key('alert_dialog${++_counter}'), parent : parent)),
                                  ControlAdder('Align',(parent)=> AlignControl(key: Key('align${++_counter}'), parent: parent)),
                                  ControlAdder('Animated Align',(parent)=> AnimatedAlignControl(key: Key('animated_align${++_counter}'), parent: parent)),
                                  ControlAdder('Animated Container',(parent)=> AnimatedContainerControl(key: Key('animated_container${++_counter}'), parent: parent)),
                                  ControlAdder('Animated Cross Fade',(parent)=> AnimatedCrossFadeControl(key: Key('animated_cross_fade${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedDefaultTextStyle',(parent)=> AnimatedDefaultTextStyleControl(key: Key('AnimatedDefaultTextStyle${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedList',(parent)=> AnimatedListControl(key: Key('AnimatedList${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedModalBarrier',(parent)=> AnimatedModalBarrierControl(key: Key('AnimatedModalBarrier${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedOpacity',(parent)=> AnimatedOpacityControl(key: Key('AnimatedOpacity${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedPhysicalModel',(parent)=> AnimatedPhysicalModelControl(key: Key('AnimatedPhysicalModel${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedPositioned',(parent)=> AnimatedPositionedControl(key: Key('AnimatedPositioned${++_counter}'), parent: parent)),
                                  ControlAdder('AnimatedSize',(parent)=> AnimatedSizeControl(key: Key('AnimatedSize${++_counter}'), parent: parent)),
                                  ControlAdder('AppBar',(parent)=> AppBarControl(key: Key('AppBar${++_counter}'), parent: parent)),
                                  ControlAdder('AspectRatio',(parent)=> AspectRatioControl(key: Key('AspectRatio${++_counter}'), parent: parent)),
                                  ControlAdder('Autocomplete',(parent)=> AutocompleteControl(key: Key('Autocomplete${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('B'),
                              isExpanded: expand[1],
                              body: Column(
                                children: [
                                  ControlAdder('Baseline',(parent)=> BaselineControl(key: Key('Baseline${++_counter}'), parent: parent)),
                                  ControlAdder('BottomAppBar',(parent)=> BottomAppBarControl(key: Key('BottomAppBar${++_counter}'), parent: parent)),
                                  ControlAdder('BottomSheet',(parent)=> BottomSheetControl(key: Key('BottomSheet${++_counter}'), parent: parent)),
                                  ControlAdder('BottomNavigationBar',(parent)=> BottomNavigationBarControl(key: Key('BottomNavigationBar${++_counter}'), parent: parent)),
                                  ControlAdder('BottomNavigationBarItem',(parent)=> BottomNavigationBarItemControl(key: Key('BottomNavigationBarItem${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('C'),
                              isExpanded: expand[2],
                              body: Column(
                                children: [
                                  ControlAdder('Card',(parent)=> CardControl(key: Key('Card${++_counter}'), parent: parent)),
                                  ControlAdder('Center',(parent)=> CenterControl(key: Key('Center${++_counter}'), parent: parent)),
                                  ControlAdder('Checkbox',(parent)=> CheckboxControl(key: Key('Checkbox${++_counter}'), parent: parent)),
                                  ControlAdder("Container", (parent) => ContainerControl(key: Key('container${++_counter}'), parent : parent)),
                                  ControlAdder('Column',(parent)=> ColumnControl(key: Key('Column${++_counter}'), parent: parent)),
                                  ControlAdder('Chip',(parent)=> ChipControl(key: Key('Chip${++_counter}'), parent: parent)),
                                  ControlAdder('ColoredBox',(parent)=> ColoredBoxControl(key: Key('ColoredBox${++_counter}'), parent: parent)),
                                  ControlAdder('CircularProgressIndicator',(parent)=> CircularProgressIndicatorControl(key: Key('CircularProgressIndicator${++_counter}'), parent: parent)),
                                  ControlAdder('ClipOval',(parent)=> ClipOvalControl(key: Key('ClipOval${++_counter}'), parent: parent)),
                                  ControlAdder('ClipPath',(parent)=> ClipPathControl(key: Key('ClipPath${++_counter}'), parent: parent)),
                                  ControlAdder('ClipRect',(parent)=> ClipRectControl(key: Key('ClipRect${++_counter}'), parent: parent)),
                                  ControlAdder('ConstrainedBox',(parent)=> ConstrainedBoxControl(key: Key('ConstrainedBox${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('D'),
                              isExpanded: expand[3],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('E'),
                              isExpanded: expand[4],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('F'),
                              isExpanded: expand[5],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('G'),
                              isExpanded: expand[6],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('H'),
                              isExpanded: expand[7],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('I'),
                              isExpanded: expand[8],
                              body: Column(
                                children: [
                                  ControlAdder('Icon',(parent)=> IconControl(key: Key('Icon${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('J'),
                              isExpanded: expand[9],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('K'),
                              isExpanded: expand[10],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('L'),
                              isExpanded: expand[11],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('M'),
                              isExpanded: expand[12],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('N'),
                              isExpanded: expand[13],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('O'),
                              isExpanded: expand[14],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('P'),
                              isExpanded: expand[15],
                              body: Column(
                                children: [
                                  ControlAdder('Padding',(parent)=> PaddingControl(key: Key('Padding${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('Q'),
                              isExpanded: expand[16],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('R'),
                              isExpanded: expand[17],
                              body: Column(
                                children: [

                                  ControlAdder('Row',(parent)=> RowControl(key: Key('Row${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('S'),
                              isExpanded: expand[18],
                              body: Column(
                                children: [
                                  ControlAdder('SizedBox',(parent)=> SizedBoxControl(key: Key('SizedBox${++_counter}'), parent: parent)),
                                  ControlAdder('Stack',(parent)=> StackControl(key: Key('Stack${++_counter}'), parent: parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('T'),
                              isExpanded: expand[19],
                              body: Column(
                                children: [
                                  ControlAdder("Text", (parent) => TextControl(key: Key('text${++_counter}'), parent : parent)),
                                ],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('U'),
                              isExpanded: expand[20],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('V'),
                              isExpanded: expand[21],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('W'),
                              isExpanded: expand[22],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('X'),
                              isExpanded: expand[23],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('Y'),
                              isExpanded: expand[24],
                              body: Column(
                                children: const [],
                              )),
                          ExpansionPanel(
                              headerBuilder: (c, b) =>  const Header('Z'),
                              isExpanded: expand[25],
                              body: Column(
                                children: const [],
                              )),


                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
          const Expanded(
            child: Window()
          ),
          const SizedBox(
            width: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white70
              ),
              child: PropertyDisplay()
            )
          )

        ],
      ),
    );
  }
}

*/