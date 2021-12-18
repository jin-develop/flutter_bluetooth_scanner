package com.polidea.flutter_ble_lib;

import android.content.Context;
import android.content.Intent;
import androidx.core.app.JobIntentService;
import android.util.Log;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.view.FlutterCallbackInformation;
import io.flutter.view.FlutterMain;
import io.flutter.view.FlutterNativeView;
import io.flutter.view.FlutterRunArguments;
import java.util.ArrayDeque;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.UUID;

public class BleBackgroundService extends MethodCallHandler, JobIntentService {
    private static final List<Intent> messagingQueue =
            Collections.synchronizedList(new LinkedList<>());

}