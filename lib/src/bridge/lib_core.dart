part of _internal;

abstract class FlutterBLE {
  final InternalBleManager _manager;

  FlutterBLE._(this._manager);

  final MethodChannel _methodChannel =
      const MethodChannel(ChannelName.flutterBleLib);
  final MethodChannel _backgroundChannel =
      const MethodChannel(ChannelName.flutterBleLibBG);

  Future<void> cancelTransaction(String transactionId) async {
    await _methodChannel.invokeMethod(MethodName.cancelTransaction,
        <String, String>{ArgumentName.transactionId: transactionId});
    return;
  }

  Future<void> initialize() async {
    final CallbackHandle? callback =
    PluginUtilities.getCallbackHandle(callbackDispatcher);
    await _methodChannel.invokeMethod('FlutterBLE.requestInitialize',
        <dynamic>[callback?.toRawHandle()]);
  }

  void callbackDispatcher() {
    const MethodChannel _backgroundChannel =
        MethodChannel(ChannelName.flutterBleLibBG);
    WidgetsFlutterBinding.ensureInitialized();

    _backgroundChannel.setMethodCallHandler((MethodCall call) async {
      print("backgroundChannel.setMethodCallHandler $call");
      // final List<dynamic> args = call.arguments;
      // final Function callback = PluginUtilities.getCallbackFromHandle(
      //     CallbackHandle.fromRawHandle(args[0]));
      // assert(callback != null);
      // final List<String> triggeringGeofences = args[1].cast<String>();
      // final List<double> locationList = <double>[];
      // // 0.0 becomes 0 somewhere during the method call, resulting in wrong
      // // runtime type (int instead of double). This is a simple way to get
      // // around casting in another complicated manner.
      // args[2]
      //     .forEach((dynamic e) => locationList.add(double.parse(e.toString())));
      // final Location triggeringLocation = locationFromList(locationList);
      // final GeofenceEvent event = intToGeofenceEvent(args[3]);
      // callback(triggeringGeofences, triggeringLocation, event);
    });
    _backgroundChannel.invokeMethod('FlutterBLE.initialized');
  }
}

class FlutterBleLib extends FlutterBLE
    with
        DeviceConnectionMixin,
        DiscoveryMixin,
        ScanningMixin,
        LogLevelMixin,
        RssiMixin,
        MtuMixin,
        BluetoothStateMixin,
        DevicesMixin,
        CharacteristicsMixin,
        DescriptorsMixin {
  final Stream<dynamic> _restoreStateEvents =
      const EventChannel(ChannelName.stateRestoreEvents)
          .receiveBroadcastStream();

  FlutterBleLib(InternalBleManager manager) : super._(manager);

  Future<List<Peripheral>> restoredState() async { 
    final peripherals = await _restoreStateEvents
      .map(
        (jsonString) {
          if (jsonString == null || 
              jsonString is String == false) {
            return null;
          }
          final restoredPeripheralsJson =
              (jsonDecode(jsonString) as List<dynamic>)
              .cast<Map<String, dynamic>>();
          return restoredPeripheralsJson
              .map((peripheralJson) =>
                  Peripheral.fromJson(peripheralJson, _manager))
              .toList();
          
        },
      )
      .take(1)
      .single;
    return peripherals ?? <Peripheral>[];
  }

  Future<bool> isClientCreated() =>
    _methodChannel.invokeMethod<bool>(MethodName.isClientCreated)
      .then((value) => value!);

  Future<void> createClient(String? restoreStateIdentifier) async {
    await _backgroundChannel.invokeMethod(MethodName.createClient, <String, String?>{
      ArgumentName.restoreStateIdentifier: restoreStateIdentifier
    });
  }

  Future<void> destroyClient() async {
    await _backgroundChannel.invokeMethod(MethodName.destroyClient);
  }
}
