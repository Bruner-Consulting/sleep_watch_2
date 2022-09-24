import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
int test = 0;
class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: const Text(
            'SleepWatch 2.0',
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "v 1.0.3 ",
                      //+ packageInfo.version,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 10) / 2),
              // width: double.maxFinite,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(),
                  icon: Icon(Icons.watch_outlined, size: 50),
                  label: Text('Serial Number', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                  },
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 10) / 2),
              //width: double.maxFinite,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       Colors.blue.shade900),
                  // ),
                  icon: Icon(Icons.view_timeline_outlined, size: 50),
                  label: Text('Last Sync', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                  },
                ),
              ),
            ),
            Container(
              //licensing
              constraints: BoxConstraints(
                  minWidth: (MediaQuery.of(context).size.width - 10) / 2),
              // width: double.maxFinite,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(),
                  icon: Icon(Icons.sync, size: 45),
                  label: Text(' Sync Device', style: TextStyle(fontSize: 24)),
                  onPressed: () async {
                  },
                ),
              ),
            ),


            // width: double.infinity,
            // child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(
            //           Colors.blue.shade900),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: Text('Exit App',
            //           style: Theme.of(context).textTheme.headline5),
            //     ),
            //     onPressed: () {
            //       SystemChannels.platform
            //           .invokeMethod('SystemNavigator.pop');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
