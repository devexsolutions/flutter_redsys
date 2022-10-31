package com.indalter.plugin_redsys;

import android.app.Activity;
import android.content.Context;
import org.json.*;

import androidx.annotation.NonNull;
import com.google.gson.Gson;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.redsys.tpvvinapplibrary.ErrorResponse;
import com.redsys.tpvvinapplibrary.IPaymentResult;
import com.redsys.tpvvinapplibrary.ResultResponse;
import com.redsys.tpvvinapplibrary.TPVV;
import com.redsys.tpvvinapplibrary.TPVVConfiguration;
import com.redsys.tpvvinapplibrary.TPVVConstants;

import java.util.Random;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;

/** PluginRedsysPlugin */
public class PluginRedsysPlugin implements FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private  Context context;
  private  Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "plugin_redsys");
    channel.setMethodCallHandler(this);
    System.out.println("ON ATTACHED TO ENGINE");
    context = flutterPluginBinding.getApplicationContext();

  }



  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result)  {

     if(call.method.equals("webPayment")) {

        TPVVConfiguration.setLicense(call.argument("license"));


        if(call.argument("environment").equals(TPVVConstants.ENVIRONMENT_REAL)){
            System.out.println("REAL ENVIRONMENT");
            TPVVConfiguration.setEnvironment(TPVVConstants.ENVIRONMENT_REAL);
        }else{
            System.out.println("TEST ENVIRONMENT");
            TPVVConfiguration.setEnvironment(TPVVConstants.ENVIRONMENT_TEST);
        }

        String reference = "";
        if(call.argument("reference").equals(TPVVConstants.REQUEST_REFERENCE)){
            reference = TPVVConstants.REQUEST_REFERENCE;
        }
        TPVVConfiguration.setFuc(call.argument("fuc"));
        TPVVConfiguration.setTerminal(call.argument("terminal"));
        TPVVConfiguration.setMerchantUrl(call.argument("merchantUrl"));
        TPVVConfiguration.setCurrency(call.argument("currency"));
        TPVVConfiguration.setPaymentMethods(call.argument("paymentMethods"));
        TPVVConfiguration.setMerchantData(call.argument("merchantData"));

        Double amount = Double.parseDouble(call.argument("amount"))*100;

        TPVV.doWebViewPayment(activity.getApplicationContext(), call.argument("order"), amount, TPVVConstants.PAYMENT_TYPE_NORMAL, reference, "Descripción", null, new IPaymentResult() {
          @Override
          public void paymentResultOK(ResultResponse response) {
            result.success(new Gson().toJson(response));

          }

          @Override
          public void paymentResultKO(ErrorResponse error) {
            result.success(new Gson().toJson(error));
          }
        });




    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
