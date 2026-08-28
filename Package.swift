// swift-tools-version:5.9
import PackageDescription

// SuperView SDK as a Swift Package.
//
// The binary xcframeworks in Frameworks/ are the same artifacts the podspec
// vendored; each public library wraps its binary plus the third-party SDK it
// needs, so an app just depends on the products for the modules it includes.
// CocoaPods distribution is discontinued (trunk goes read-only 2026-12-02).
//
// Modules not (yet) exposed via SPM: Firebase, Facebook (pending dependency
// review) and CardScan (upstream abandoned — scheduled for removal).

let package = Package(
    name: "SuperView",
    platforms: [
        .iOS("15.6")
    ],
    products: [
        .library(name: "SuperViewCore", targets: ["SuperViewCoreModule"]),
        .library(name: "SuperViewOneSignal", targets: ["SuperViewOneSignalModule"]),
        .library(name: "SuperViewAdMob", targets: ["SuperViewAdMobModule"]),
        .library(name: "SuperViewLocation", targets: ["SuperViewLocationModule"]),
        .library(name: "SuperViewQR", targets: ["SuperViewQRModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OneSignal/OneSignal-XCFramework.git", exact: "5.2.9"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", exact: "11.13.0"),
    ],
    targets: [
        // Prebuilt, module-stable binaries (BUILD_LIBRARY_FOR_DISTRIBUTION).
        .binaryTarget(name: "SuperViewCore", path: "Frameworks/SuperViewCore.xcframework"),
        .binaryTarget(name: "SuperViewOneSignal", path: "Frameworks/SuperViewOneSignal.xcframework"),
        .binaryTarget(name: "SuperViewAdMob", path: "Frameworks/SuperViewAdMob.xcframework"),
        .binaryTarget(name: "SuperViewLocation", path: "Frameworks/SuperViewLocation.xcframework"),
        .binaryTarget(name: "SuperViewQR", path: "Frameworks/SuperViewQR.xcframework"),

        // Wrapper targets attach dependencies to the binaries (a binaryTarget
        // cannot declare its own). Apps keep importing the binary module
        // names: `import SuperViewCore`, `import SuperViewOneSignal`, ...
        .target(
            name: "SuperViewCoreModule",
            dependencies: ["SuperViewCore"],
            path: "SwiftPM/Core"
        ),
        .target(
            name: "SuperViewOneSignalModule",
            dependencies: [
                "SuperViewOneSignal",
                "SuperViewCoreModule",
                .product(name: "OneSignalFramework", package: "OneSignal-XCFramework"),
            ],
            path: "SwiftPM/OneSignal"
        ),
        .target(
            name: "SuperViewAdMobModule",
            dependencies: [
                "SuperViewAdMob",
                "SuperViewCoreModule",
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "SwiftPM/AdMob"
        ),
        .target(
            name: "SuperViewLocationModule",
            dependencies: ["SuperViewLocation", "SuperViewCoreModule"],
            path: "SwiftPM/Location"
        ),
        .target(
            name: "SuperViewQRModule",
            dependencies: ["SuperViewQR", "SuperViewCoreModule"],
            path: "SwiftPM/QR"
        ),
    ]
)
