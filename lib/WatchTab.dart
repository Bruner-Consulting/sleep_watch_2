import 'package:flutter/material.dart';

class WatchTab extends StatefulWidget {
  const WatchTab({Key? key}) : super(key: key);

  @override
  State<WatchTab> createState() => _WatchTabState();
}

class _WatchTabState extends State<WatchTab> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                  EdgeInsets.fromLTRB(8,16,8,0),
                  child: Text(
                    "Serial Number",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(8,0,8,32),
                  child: Container(
                   // width: 300,
                    height: 50,
                    decoration: ShapeDecoration(
    color: Theme.of(context).highlightColor,
                       // color: Colors.white,
                        shape: RoundedRectangleBorder (
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                                width: 1,
                            color: Theme.of(context).colorScheme.primary,
                            )
                        )
                    ),
                    child: const Center(
                        child: Text(
                            "123456",
                            style: TextStyle(fontSize: 18)
                        )
                    ),
                  )
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    // child: Center(
                    //   //crossAxisAlignment: CrossAxisAlignment.center,
                    //   child:
                    //     ElevatedButton.icon(
                    //       style: ButtonStyle(
                    //       ),
                    //       icon: Icon(Icons.download_outlined, size: 30),
                    //       label: Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: Text('Download Watch & \n Send to E-mail', style: TextStyle(fontSize: 22)),
                    //       ),
                    //       onPressed: () {
                    //         // Navigator.pop(context);
                    //         // pvt_data.E_Initials = EI_Controller.text;
                    //         // pvt_data.S_Initials = SI_Controller.text;
                    //         // pvt_data.S_ID = SID_Controller.text;
                    //         // pvt_data.Main_Email = Email_Controller.text;
                    //         // _setPreference();
                    //        // Navigator.pop(context);
                    //         // Navigator.pop(context);pushReplacement(
                    //         //     context,
                    //         //     MaterialPageRoute(
                    //         //         builder: (context) =>
                    //         //             //  ConfigPage(title: 'PVT - Configure Session')));
                    //         //             MainMenu(title: 'Main Menu')));
                    //       },
                    //     ),
                    //  // ],
                    // ),
                  ),
                ),
                const Padding(
                  //THIS AREA FOR EMAIL ADDRESS FOR SENDING DATA FILES
                  //right now can only enter email, does not send nor validate
                  padding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "Specify e-mail address to send data to, then press button below to download watch and initiate email.",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: TextField(
                //    controller: Email_Controller,
                    cursorColor: Colors.grey,
                    cursorHeight: 30,
                    maxLines: 1,
                    maxLength: 50,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                    //style: Theme.of(context).textTheme.headline6,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey, width: 2),
                        borderRadius:
                        BorderRadius.all(Radius.circular(16)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onChanged: (String value) {
                     // final email = value;
                    },
                  ),
                ), //END OF EMAIL AREA
              ],
            ),
          ), // User Notes

          Column(
            children: [
              ElevatedButton.icon(
                style: const ButtonStyle(
                ),
                icon: const Icon(Icons.download, size: 30),
                label: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Download & \n Send Data', style: TextStyle(fontSize: 22)),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                  // pvt_data.E_Initials = EI_Controller.text;
                  // pvt_data.S_Initials = SI_Controller.text;
                  // pvt_data.S_ID = SID_Controller.text;
                  // pvt_data.Main_Email = Email_Controller.text;
                  // _setPreference();
                 // Navigator.pop(context);
                  // Navigator.pop(context);pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             //  ConfigPage(title: 'PVT - Configure Session')));
                  //             MainMenu(title: 'Main Menu')));
                },
              ),
              const Padding(
                padding:
                EdgeInsets.fromLTRB(8,16,8,0),
                child: Text(
                  "BLE Comm Status",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.fromLTRB(8,0,8,32),
                  child: Container(
                    // width: 300,
                    height: 50,
                    decoration: ShapeDecoration(
                        color: Theme.of(context).highlightColor,
                        // color: Colors.white,
                        shape: RoundedRectangleBorder (
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary,
                            )
                        )
                    ),
                    child: const Center(
                        child: Text(
                            "communication status",
                            style: TextStyle(fontSize: 18)
                        )
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
     }
}
