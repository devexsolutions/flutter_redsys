import Flutter
import UIKit
import TPVVInLibrary

public class SwiftPluginRedsysPlugin: NSObject, FlutterPlugin,  WebViewPaymentResponseDelegate {

    var resultLocal: FlutterResult?


    public func responsePaymentKO(response: (WebViewPaymentResponseKO)) {

        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(response)
        let json = String(data: jsonData, encoding: String.Encoding.utf8) as! String
        resultLocal!(json )

    }

    public func responsePaymentOK(response: (WebViewPaymentResponseOK)) {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(response)
        let json = String(data: jsonData, encoding: String.Encoding.utf8) as! String
        resultLocal!(json )
    }


    init(pluginRegistrar: FlutterPluginRegistrar, uiViewController: UIViewController) {
       }
    
   
    public static func register(with registrar: FlutterPluginRegistrar) {
            let channel = FlutterMethodChannel(name: "plugin_redsys", binaryMessenger: registrar.messenger())
            
            let viewController: UIViewController =
                (UIApplication.shared.delegate?.window??.rootViewController)!;
            
            let instance = SwiftPluginRedsysPlugin(pluginRegistrar: registrar, uiViewController: viewController)
            registrar.addMethodCallDelegate(instance, channel: channel)
        }
    


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

      resultLocal = result

      let viewController: UIViewController


      if call.method == "webPayment" {
          print("CALLED METHOD SDK");

          let myArgs = call.arguments as? [String: Any]

          TPVVConfiguration.shared.appLicense = myArgs!["license"] as! String
          TPVVConfiguration.shared.appFuc = myArgs!["fuc"] as! String
          TPVVConfiguration.shared.appTerminal = myArgs!["terminal"] as! String
          TPVVConfiguration.shared.appMerchantURL = myArgs!["merchantUrl"] as! String
          TPVVConfiguration.shared.appCurrency = myArgs!["currency"] as! String

          let paymentMethods =  myArgs!["paymentMethods"] as! String

          TPVVConfiguration.shared.appMerchantPayMethods = PaymentMethod.card


          let env = myArgs!["environment"] as! String

          if env == "2" {
            TPVVConfiguration.shared.appEnviroment = EnviromentType.Real
          }else{
            TPVVConfiguration.shared.appEnviroment = EnviromentType.Test
          }
          TPVVConfiguration.shared.appMerchantData = myArgs!["merchantData"] as! String

          let order = myArgs!["order"] as! String
          let amount = Double(myArgs!["amount"] as! String) as! Double
          let reference:String = myArgs!["reference"] as! String

          let dpView = WebViewPaymentController(orderNumber: order, amount: amount,
                                                   productDescription: "COMPRA", transactionType: TransactionType.normal, identifier: reference,extraParams:[:])
             
          dpView.delegate = self

          UIApplication.shared.delegate?.window??.rootViewController?.present(dpView, animated: true, completion: nil)

      }
      
  }
}
