import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sleepwatch2/WatchTab.dart';
import 'package:sleepwatch2/SleepTab.dart';
import 'package:sleepwatch2/ChartTab.dart';




class SleepTab extends StatefulWidget {
  const SleepTab({Key? key}) : super(key: key);

  @override
  State<SleepTab> createState() => _SleepTabState();
}

class _SleepTabState extends State<SleepTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.fast_rewind,), onPressed: () {},),
            IconButton(icon: Icon(Icons.calendar_month), onPressed: () {},),
            IconButton(icon: Icon(Icons.fast_forward), onPressed: () {},),
          ],
        ),
      ),
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).highlightColor,
  //       actions: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //
  //             children: [
  //               ElevatedButton.icon(
  //                 style: ButtonStyle(
  //                   shape: MaterialStateProperty.all(
  //                     RoundedRectangleBorder(
  //                       // Change your radius here
  //                       borderRadius: BorderRadius.circular(0),
  //                     ),
  //                   ),
  //                  //   backgroundColor: MaterialStateProperty.all(Theme.of(context).secondaryHeaderColor)
  //                                     ),
  //                 icon: Icon(Icons.fast_rewind, size: 16),
  //                 label: Padding(
  //                   padding: const EdgeInsets.all(0.0),
  //                   child: Text('First', style: TextStyle(fontSize: 14)),
  //                                   ),
  //                 onPressed: () {
  //                 },
  //               ),
  //              // Spacer(),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
  //                 child: ElevatedButton.icon(
  //                   style: ButtonStyle(
  //                     shape: MaterialStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         // Change your radius here
  //                         borderRadius: BorderRadius.circular(0),
  //                       ),
  //                     ),
  //                     //   backgroundColor: MaterialStateProperty.all(Theme.of(context).secondaryHeaderColor)
  //
  //                   ),
  //                   icon: Icon(Icons.calendar_month, size: 18),
  //                   label: Padding(
  //                     padding: const EdgeInsets.all(0.0),
  //                     child: Text('Choose Date', style: TextStyle(fontSize: 16)),
  //
  //                   ),
  //                   onPressed: () {
  //                   },
  //                 ),
  //               ),
  //               ElevatedButton.icon(
  //                 style: ButtonStyle(
  //                   shape: MaterialStateProperty.all(
  //                     RoundedRectangleBorder(
  //                       // Change your radius here
  //                       borderRadius: BorderRadius.circular(0),
  //                     ),
  //                   ),
  //                   //   backgroundColor: MaterialStateProperty.all(Theme.of(context).secondaryHeaderColor)
  //
  //                 ),
  //                 icon: Icon(Icons.fast_forward, size: 18),
  //                 label: Padding(
  //                   padding: const EdgeInsets.all(0.0),
  //                   child: Text('Last', style: TextStyle(fontSize: 16)),
  //
  //
  //                 ),
  //                 onPressed: () {
  //                 },
  //               ),
  // //  Spacer(1),
  //
  //             ],
  //           ),
  //         ),
  //       ],
  //
  //     ),
      body: Center(


        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("01/01/22", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),],),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("In Bed Time", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("21:24", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mins to Fall Asleep", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("00:19", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Final Awaking Time", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("01:24", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Out of Bed", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("02:19", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Sleep Time", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("07:50", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Wake After Sleep Onset (WASO)", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("5", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sleep Efficiency", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("89%", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("% Restlessness", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("16%", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Steps Taken Before Bed", textAlign: TextAlign.start,style: TextStyle(fontSize: 16)),
                        Text("7,890", textAlign: TextAlign.end,style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),

                ],

              ),
            ),


          ],
        ),
      ),
    );
  }
}
