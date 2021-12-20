package com.polidea.flutter_ble_lib.constant;

public interface ChannelName {
    String FLUTTER_BLE_LIB = "flutter_ble_lib";
    String FLUTTER_BLE_LIB_BG = "flutter_ble_lib_bg";
    String ADAPTER_STATE_CHANGES = FLUTTER_BLE_LIB + "/stateChanges";
    String STATE_RESTORE_EVENTS = FLUTTER_BLE_LIB + "/stateRestoreEvents";
    String SCANNING_EVENTS = FLUTTER_BLE_LIB + "/scanningEvents";
    String ADAPTER_STATE_CHANGES_BG = FLUTTER_BLE_LIB_BG + "/stateChanges";
    String STATE_RESTORE_EVENTS_BG = FLUTTER_BLE_LIB_BG + "/stateRestoreEvents";
    String SCANNING_EVENTS_BG = FLUTTER_BLE_LIB_BG + "/scanningEvents";
    String CONNECTION_STATE_CHANGE_EVENTS = FLUTTER_BLE_LIB + "/connectionStateChangeEvents";
    String MONITOR_CHARACTERISTIC = FLUTTER_BLE_LIB + "/monitorCharacteristic";
}
