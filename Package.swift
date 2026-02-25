// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SuperView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "SuperViewCore", targets: ["SuperViewCoreWrapper"]),
        .library(name: "SuperViewOneSignal", targets: ["SuperViewOneSignalWrapper"]),
        .library(name: "SuperViewAdMob", targets: ["SuperViewAdMobWrapper"]),
        .library(name: "SuperViewFirebase", targets: ["SuperViewFirebaseWrapper"]),
        .library(name: "SuperViewLocation", targets: ["SuperViewLocationWrapper"]),
        .library(name: "SuperViewQR", targets: ["SuperViewQRWrapper"]),
        .library(name: "SuperViewCardScan", targets: ["SuperViewCardScanWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OneSignal/OneSignal-XCFramework.git", from: "5.2.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", from: "11.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.0.0"),
    ],
    targets: [
        // Binary targets for xcframeworks
        .binaryTarget(
            name: "SuperViewCore",
            path: "Frameworks/SuperViewCore.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewOneSignalBinary",
            path: "Frameworks/SuperViewOneSignal.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewAdMobBinary",
            path: "Frameworks/SuperViewAdMob.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewFirebaseBinary",
            path: "Frameworks/SuperViewFirebase.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewLocationBinary",
            path: "Frameworks/SuperViewLocation.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewQRBinary",
            path: "Frameworks/SuperViewQR.xcframework"
        ),
        .binaryTarget(
            name: "SuperViewCardScanBinary",
            path: "Frameworks/SuperViewCardScan.xcframework"
        ),

        // Wrapper targets to combine binary frameworks with dependencies
        .target(
            name: "SuperViewCoreWrapper",
            dependencies: ["SuperViewCore"],
            path: "SPMSupport/Core"
        ),
        .target(
            name: "SuperViewOneSignalWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewOneSignalBinary",
                .product(name: "OneSignalFramework", package: "OneSignal-XCFramework"),
            ],
            path: "SPMSupport/OneSignal"
        ),
        .target(
            name: "SuperViewAdMobWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewAdMobBinary",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "SPMSupport/AdMob"
        ),
        .target(
            name: "SuperViewFirebaseWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewFirebaseBinary",
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
            ],
            path: "SPMSupport/Firebase"
        ),
        .target(
            name: "SuperViewLocationWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewLocationBinary",
            ],
            path: "SPMSupport/Location"
        ),
        .target(
            name: "SuperViewQRWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewQRBinary",
            ],
            path: "SPMSupport/QR"
        ),
        .target(
            name: "SuperViewCardScanWrapper",
            dependencies: [
                "SuperViewCoreWrapper",
                "SuperViewCardScanBinary",
            ],
            path: "SPMSupport/CardScan"
        ),
    ]
)
