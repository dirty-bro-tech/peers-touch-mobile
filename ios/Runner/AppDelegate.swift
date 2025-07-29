import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register plugins first
    GeneratedPluginRegistrant.register(with: self)
    
    // Then set up our custom method channel
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    let storageChannel = FlutterMethodChannel(name: "samples.flutter.dev/storage",
                                              binaryMessenger: controller.binaryMessenger)
    
    storageChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }
      
      switch call.method {
      case "getFreeDiskSpace":
        self.getFreeDiskSpace(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getFreeDiskSpace(result: FlutterResult) {
    do {
      // Try the modern API first
      if #available(iOS 11.0, *) {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
        if let capacity = values.volumeAvailableCapacityForImportantUsage {
          print("Free space: \(Double(capacity) / (1024 * 1024)) MB")
          result(["freeSpace": capacity])
          return
        }
      }
      
      // Try alternative method if the first one fails
      let fileManager = FileManager.default
      let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
      let attributes = try fileManager.attributesOfFileSystem(forPath: documentDirectory.path)
      if let freeSize = attributes[.systemFreeSize] as? NSNumber {
        let freeSpace = freeSize.int64Value
        print("Free space (alternative): \(Double(freeSpace) / (1024 * 1024)) MB")
        result(["freeSpace": freeSpace])
        return
      }
      
      // Fallback to a default value if we can't get the actual free space
      print("Using default free space value")
      result(["freeSpace": 500 * 1024 * 1024]) // 500MB default
    } catch {
      print("Error getting disk space: \(error)")
      result(["freeSpace": 500 * 1024 * 1024]) // 500MB default
    }
  }
}
