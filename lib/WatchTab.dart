import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:path_provider/path_provider.dart';
import 'package:location_permissions/location_permissions.dart';
import 'dart:io' show Platform;
import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';

// This flutter app demonstrates an usage of the flutter_reactive_ble flutter plugin
// This app works only with BLE devices which advertise with a Nordic UART Service (NUS) UUID
Uuid _UART_UUID = Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
Uuid _UART_RX = Uuid.parse("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");
Uuid _UART_TX = Uuid.parse("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");
String myBuffer = '';
String myFile = "zcm.txt";

class WatchTab extends StatefulWidget {
  const WatchTab({Key? key}) : super(key: key);

  @override
  State<WatchTab> createState() => _WatchTabState();
}

class _WatchTabState extends State<WatchTab> {
  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> _foundBleUARTDevices = [];
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _rxCharacteristic;
  late Stream<List<int>> _receivedDataStream;
  late TextEditingController _dataToSendText;
  bool _scanning = false;
  bool _connected = false;
  bool inFile = false;
  String _logTexts = "";
  List<String> _receivedData = [];
  int _numberOfMessagesReceived = 0;
  String textData = "";
  bool downloading = false;
  String downloadText = 'Download & Send Data';

  void initState() {
    super.initState();
    _dataToSendText = TextEditingController();
  }

  void refreshScreen() {
    setState(() {});
  }

  void updateCommStatus(String data) {
    setState(() {
      textData = "$textData$data\n";
    });
  }

  void _sendData(String command) async {
    //var files = ["zcmDl();", "pvtDl();"];
    print("sending command => $command");
    updateCommStatus("sending command => $command");
    await flutterReactiveBle.writeCharacteristicWithResponse(_rxCharacteristic,
        value: command.codeUnits);
  }

//TODO  add a filter to only capture text between < and >.  For
  // Example "<abcd>" would only add "abcd" to mybuffer.
  // need a state variable (inside_brackets).  If false then looking for
  // '<'.  If true, routing all strings to myBuffer until a '>' is found
  // Remember data is a list<int>  should convert to string first.
  //  Very unlikely that a '<' and '>' will been in one session of data.
  int num_chars = 0;
  void onNewReceivedData(List<int> data) async {
    _numberOfMessagesReceived += 1;
    String testStr = String.fromCharCodes(data);
    updateCommStatus("incoming data => $testStr");
    for (var i = 0; i < data.length; i++) {
      var character = data[i];
      var stringCharacter = String.fromCharCode(character);
      print("found string => $stringCharacter");
      if (!inFile) {
        if (stringCharacter == "{") {
          print("found {");
          updateCommStatus("found {");
          inFile = true;
        }
      } else {
        if (stringCharacter == "}") {
          inFile = false;
          print("found }");
          updateCommStatus("found }");
          //print(myBuffer);
          await writeFile();
          readFile();
          if (myFile == "zcm.txt") {
            num_chars = 0;
            myFile = "demo.pvt";
            myBuffer = '';
            print("sending pvtDl();");
            updateCommStatus("sending pvtDl();");
            _sendData('pvtDl();\n');
          } else if (myFile == "demo.pvt") {
            print("send email");
            updateCommStatus("send email");
            send_email();
            myFile = "blank.txt";
            print("sending zcmStart");
            updateCommStatus("sending zcmStart");
            _sendData('restartZCM();\n');
          } else if (myFile == "blank.txt") {
            print("disconnecting");
            updateCommStatus("disconnecting");
            _disconnect();
            setState(() {
              downloading = false;
            });
          }
        } else {
          num_chars++;
          myBuffer = myBuffer + stringCharacter;
        }
      }
    }
    refreshScreen();
  }

  void _disconnect() async {
    await _connection.cancel();
    _connected = false;
    refreshScreen();
  }

  void _stopScan() async {
    await _scanStream.cancel();
    _scanning = false;
    refreshScreen();
  }

  //TODO FILE CREATION

  Future<String?> get _localPath async {
    WidgetsFlutterBinding.ensureInitialized();
    //final directory = await getApplicationDocumentsDirectory();
    final Directory? directory = await getExternalStorageDirectory();

    return directory?.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('$path/$myFile');
    return File('$path/$myFile');
  }

  Future<bool> readFile() async {
    try {
      final file = await _localFile;
      print("inside readFile");
      // Read the file
      final contents = await file.readAsString();
      //print("here is the file contents=============================");
      // print(contents);
      //print("end file contents=============================");
      return true;
    } catch (e) {
      // If encountering an error, return 0
      print("catch in readFile");
      return false;
    }
  }

  Future<File> writeFile() async {
    final file = await _localFile;
    try {
      await file.delete;
    } catch (e) {
      print(e);
    }
    print("writing file $myFile");
    try {
      // force a file creation
      file.writeAsStringSync("");
      file.writeAsStringSync("$myBuffer\r\n", mode: FileMode.append);
    } catch (e) {
      print("error writing file");
    }
    // Write the file
    return file;
  }

  Future<void> send_email() async {
    final path = await _localPath;
    List<String> myattachment = ['$path/zcm.txt', '$path/demo.pvt'];
    print("Attachments for email");
    print(myattachment);
    final Email email = Email(
      body: 'Downloaded data from SleepWatch',
      subject: 'SleepWatch Data',
      recipients: [
        "marty@bruner-consulting.com",
        "jordan@bruner-consulting.com",
        "tomk@ambulatory-monitoring.com"
      ],
      attachmentPaths: myattachment,
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
      print('success');
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> showNoPermissionDialog() async => showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No location permission '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('No location permission granted.'),
                const Text(
                    'Location permission is required for BLE to function.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Acknowledge'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  void _startScan() async {
    bool goForIt = false;
    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) goForIt = true;
    } else if (Platform.isIOS) {
      goForIt = true;
    }
    if (goForIt) {
      //TODO replace True with permission == PermissionStatus.granted is for IOS test
      _foundBleUARTDevices = [];
      _scanning = true;
      refreshScreen();
      print("starting scan...");
      updateCommStatus("starting scan...");
      _scanStream = flutterReactiveBle
          .scanForDevices(withServices: [_UART_UUID]).listen((device) async {
        if (_foundBleUARTDevices.every((element) => element.id != device.id)) {
          _foundBleUARTDevices.add(device);
          print("${device.name}  ${device.id}");
          updateCommStatus("${device.name}  ${device.id}");
          if (device.name.contains('Bangle.js')) {
            print("found Bangle");
            updateCommStatus("found Bangle");
            await _scanStream.cancel();
            onConnectDevice(device);
          }
          refreshScreen();
        }
      }, onError: (Object error) {
        _logTexts = "${_logTexts}ERROR while scanning:$error \n";
        print("Error in Scan");
        updateCommStatus("Error in Scan");
        refreshScreen();
      });
    } else {
      await showNoPermissionDialog();
    }
  }

  void onConnectDevice(device) {
    _currentConnectionStream = flutterReactiveBle.connectToAdvertisingDevice(
      id: device.id, //_foundBleUARTDevices[index].id,
      prescanDuration: Duration(seconds: 2),
      withServices: [_UART_UUID, _UART_RX, _UART_TX],
    );
    _logTexts = "";
    refreshScreen();
    _connection = _currentConnectionStream.listen((event) {
      var id = event.deviceId.toString();
      switch (event.connectionState) {
        case DeviceConnectionState.connecting:
          {
            _logTexts = "${_logTexts}Connecting to $id\n";
            print("attempting to connect to=> " + device.name);
            updateCommStatus("attempting to connect to=> " + device.name);
            break;
          }
        case DeviceConnectionState.connected:
          {
            _connected = true;
            _logTexts = "${_logTexts}Connected to $id\n";
            print("connected to $id");
            updateCommStatus("connected to $id");
            _numberOfMessagesReceived = 0;
            _receivedData = [];
            _txCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _UART_TX,
                deviceId: event.deviceId);
            _receivedDataStream =
                flutterReactiveBle.subscribeToCharacteristic(_txCharacteristic);
            _receivedDataStream.listen((data) {
              onNewReceivedData(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _rxCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _UART_RX,
                deviceId: event.deviceId);
            print("sending command");
            updateCommStatus("sending zcmDl();");
            _sendData('zcmDl();\n');
            break;
          }
        case DeviceConnectionState.disconnecting:
          {
            _connected = false;
            _logTexts = "${_logTexts}Disconnecting from $id\n";
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            _logTexts = "${_logTexts}Disconnected from $id\n";
            break;
          }
      }
      refreshScreen();
    });
  }

  Widget myWidget() {
    if (!downloading) {
      return const Text('Download & Send Data', style: TextStyle(fontSize: 16));
    } else {
      return const Text('Downloading ', style: TextStyle(fontSize: 16));
    }
  }

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
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                  child: Text(
                    "Serial Number",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
                    child: Container(
                      // width: 300,
                      height: 50,
                      decoration: ShapeDecoration(
                          color: Theme.of(context).highlightColor,
                          // color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                              ))),
                      child: const Center(
                          child:
                              Text("123456", style: TextStyle(fontSize: 18))),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                ),
                // const Padding(
                //   //THIS AREA FOR EMAIL ADDRESS FOR SENDING DATA FILES
                //   //right now can only enter email, does not send nor validate
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                //   child: Text(
                //     "Specify e-mail address, then press button to download watch and initiate email.",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                //   child: TextField(
                //     //    controller: Email_Controller,
                //     cursorColor: Colors.grey,
                //     cursorHeight: 30,
                //     maxLines: 1,
                //     maxLength: 50,
                //     style: const TextStyle(fontWeight: FontWeight.normal),
                //     //style: Theme.of(context).textTheme.headline6,
                //     decoration: const InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey, width: 2),
                //         borderRadius: BorderRadius.all(Radius.circular(16)),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //       ),
                //     ),
                //     onChanged: (String value) {
                //       // final email = value;
                //     },
                //   ),
                // ), //END OF EMAIL AREA
              ],
            ),
          ), // User Notes

          Column(
            children: [
              Container(
                constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 100) / 4),
                child: ElevatedButton.icon(
                  style: const ButtonStyle(),
                  icon: const Icon(Icons.download, size: 30),
                  label: !downloading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Synchronize and Send Data',
                              style: TextStyle(fontSize: 16)),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Synchronizing',
                              style: TextStyle(fontSize: 16))),
                  onPressed: () {
                    if (!downloading) {
                      setState(() {
                        downloading = true;
                      });
                      textData = "";
                      myFile = "zcm.txt";
                      _startScan();
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                child: Text(
                  "BLE Comm Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: (MediaQuery.of(context).size.width)),
                    // width: 300,
                    height: 150,
                    decoration: ShapeDecoration(
                        color: Theme.of(context).highlightColor,
                        // color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary,
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(textData, style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
