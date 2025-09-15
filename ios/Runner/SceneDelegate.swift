import Flutter
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var storageChannel: FlutterMethodChannel?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // Create a FlutterViewController and set it as the root view controller
        let flutterViewController = FlutterViewController()
        window.rootViewController = flutterViewController
        
        // Register plugins
        GeneratedPluginRegistrant.register(with: flutterViewController)
        
        // Set up our custom method channel
        self.storageChannel = FlutterMethodChannel(name: "samples.flutter.dev/storage",
                                                  binaryMessenger: flutterViewController.binaryMessenger)
        
        self.storageChannel?.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else { return }
            
            switch call.method {
            case "getFreeDiskSpace":
                self.getFreeDiskSpace(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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