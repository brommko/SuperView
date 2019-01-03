// Generated by Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import CoreGraphics;
@import Foundation;
@import GCDWebServer;
@import GoogleMobileAds;
@import ObjectiveC;
@import SafariServices;
@import StoreKit;
@import UIKit;
@import WebKit;
#endif

#import <SuperView/SuperView.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="SuperView",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


/// Bridge for WKWebView and JavaScript
SWIFT_CLASS("_TtC9SuperView6Bridge")
@interface Bridge : NSObject
- (void)observeValueForKeyPath:(NSString * _Nullable)keyPath ofObject:(id _Nullable)object change:(NSDictionary<NSKeyValueChangeKey, id> * _Nullable)change context:(void * _Nullable)context;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@class WKUserContentController;
@class WKScriptMessage;

@interface Bridge (SWIFT_EXTENSION(SuperView)) <WKScriptMessageHandler>
- (void)userContentController:(WKUserContentController * _Nonnull)userContentController didReceiveScriptMessage:(WKScriptMessage * _Nonnull)message;
@end




SWIFT_CLASS("_TtC9SuperView9IAPHelper")
@interface IAPHelper : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@class SKProductsRequest;
@class SKProductsResponse;

@interface IAPHelper (SWIFT_EXTENSION(SuperView)) <SKProductsRequestDelegate>
- (void)productsRequest:(SKProductsRequest * _Nonnull)request didReceiveResponse:(SKProductsResponse * _Nonnull)response;
@end

@class SKPaymentQueue;
@class SKPaymentTransaction;

@interface IAPHelper (SWIFT_EXTENSION(SuperView)) <SKPaymentTransactionObserver>
- (void)paymentQueue:(SKPaymentQueue * _Nonnull)queue updatedTransactions:(NSArray<SKPaymentTransaction *> * _Nonnull)transactions;
@end



@class UIColor;
@class NSCoder;

/// Activity indicator view with nice animations
SWIFT_CLASS("_TtC9SuperView23NVActivityIndicatorView")
@interface NVActivityIndicatorView : UIView
/// Color of activity indicator view.
@property (nonatomic, strong) UIColor * _Nonnull color;
/// Padding of activity indicator view.
@property (nonatomic) CGFloat padding;
/// Returns an object initialized from data in a given unarchiver.
/// self, initialized using the data in decoder.
/// \param decoder an unarchiver object.
///
///
/// returns:
/// self, initialized using the data in decoder.
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
/// Returns the natural size for the receiving view, considering only properties of the view itself.
/// A size indicating the natural size for the receiving view based on its intrinsic properties.
///
/// returns:
/// A size indicating the natural size for the receiving view based on its intrinsic properties.
@property (nonatomic, readonly) CGSize intrinsicContentSize;
@property (nonatomic) CGRect bounds;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@end

/// The direction of scrolling that the navigation bar should be collapsed.
/// The raw value determines the sign of content offset depending of collapse direction.
/// <ul>
///   <li>
///     scrollUp: scrolling up direction
///   </li>
///   <li>
///     scrollDown: scrolling down direction
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, NavigationBarCollapseDirection, closed) {
  NavigationBarCollapseDirectionScrollUp = -1,
  NavigationBarCollapseDirectionScrollDown = 1,
};

enum NavigationBarFollowerCollapseDirection : NSInteger;

/// Wraps a view that follows the navigation bar, providing the direction that the view should follow
SWIFT_CLASS("_TtC9SuperView21NavigationBarFollower")
@interface NavigationBarFollower : NSObject
@property (nonatomic, weak) UIView * _Nullable view;
@property (nonatomic) enum NavigationBarFollowerCollapseDirection direction;
- (nonnull instancetype)initWithView:(UIView * _Nonnull)view direction:(enum NavigationBarFollowerCollapseDirection)direction OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

/// The direction of scrolling that a followe should follow when the navbar is collapsing.
/// The raw value determines the sign of content offset depending of collapse direction.
/// <ul>
///   <li>
///     scrollUp: scrolling up direction
///   </li>
///   <li>
///     scrollDown: scrolling down direction
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, NavigationBarFollowerCollapseDirection, closed) {
  NavigationBarFollowerCollapseDirectionScrollUp = -1,
  NavigationBarFollowerCollapseDirectionScrollDown = 1,
};

/// The state of the navigation bar
/// <ul>
///   <li>
///     collapsed: the navigation bar is fully collapsed
///   </li>
///   <li>
///     expanded: the navigation bar is fully visible
///   </li>
///   <li>
///     scrolling: the navigation bar is transitioning to either <code>Collapsed</code> or <code>Scrolling</code>
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, NavigationBarState, closed) {
  NavigationBarStateCollapsed = 0,
  NavigationBarStateExpanded = 1,
  NavigationBarStateScrolling = 2,
};

@protocol ScrollingNavigationControllerDelegate;
@class UIPanGestureRecognizer;
@protocol UIViewControllerTransitionCoordinator;
@class UIGestureRecognizer;
@class UITouch;
@class UIViewController;

/// A custom <code>UINavigationController</code> that enables the scrolling of the navigation bar alongside the
/// scrolling of an observed content view
SWIFT_CLASS("_TtC9SuperView29ScrollingNavigationController")
@interface ScrollingNavigationController : UINavigationController <UIGestureRecognizerDelegate>
/// Returns the <code>NavigationBarState</code> of the navigation bar
@property (nonatomic, readonly) enum NavigationBarState state;
/// Determines whether the navbar should scroll when the content inside the scrollview fits
/// the view’s size. Defaults to <code>false</code>
@property (nonatomic) BOOL shouldScrollWhenContentFits;
/// Determines if the navbar should expand once the application becomes active after entering background
/// Defaults to <code>true</code>
@property (nonatomic) BOOL expandOnActive;
/// Determines if the navbar scrolling is enabled.
/// Defaults to <code>true</code>
@property (nonatomic) BOOL scrollingEnabled;
/// The delegate for the scrolling navbar controller
@property (nonatomic, weak) id <ScrollingNavigationControllerDelegate> _Nullable scrollingNavbarDelegate;
/// An array of <code>NavigationBarFollower</code>s that will follow the navbar
@property (nonatomic, copy) NSArray<NavigationBarFollower *> * _Nonnull followers;
/// Determines if the top content inset should be updated with the navbar’s delta movement. This should be enabled when dealing with table views with floating headers.
/// It can however cause issues in certain configurations. If the issues arise, set this to false
/// Defaults to <code>true</code>
@property (nonatomic) BOOL shouldUpdateContentInset;
/// Determines if the navigation bar should scroll while following a UITableView that is in edit mode.
/// Defaults to <code>false</code>
@property (nonatomic) BOOL shouldScrollWhenTableViewIsEditing;
/// Holds the percentage of the navigation bar that is hidde. At 0 the navigation bar is fully visible, at 1 fully hidden. CGFloat with values from 0 to 1
@property (nonatomic, readonly) CGFloat percentage;
@property (nonatomic, readonly, strong) UIPanGestureRecognizer * _Nullable gestureRecognizer;
/// Start scrolling
/// Enables the scrolling by observing a view
/// \param scrollableView The view with the scrolling content that will be observed
///
/// \param delay The delay expressed in points that determines the scrolling resistance. Defaults to <code>0</code>
///
/// \param scrollSpeedFactor This factor determines the speed of the scrolling content toward the navigation bar animation
///
/// \param collapseDirection The direction of scrolling that the navigation bar should be collapsed
///
/// \param followers An array of <code>NavigationBarFollower</code>s that will follow the navbar. The wrapper holds the direction that the view will follow
///
- (void)followScrollView:(UIView * _Nonnull)scrollableView delay:(double)delay scrollSpeedFactor:(double)scrollSpeedFactor collapseDirection:(enum NavigationBarCollapseDirection)collapseDirection followers:(NSArray<NavigationBarFollower *> * _Nonnull)followers;
/// Hide the navigation bar
/// \param animated If true the scrolling is animated. Defaults to <code>true</code>
///
/// \param duration Optional animation duration. Defaults to 0.1
///
- (void)hideNavbarWithAnimated:(BOOL)animated duration:(NSTimeInterval)duration;
/// Show the navigation bar
/// \param animated If true the scrolling is animated. Defaults to <code>true</code>
///
/// \param duration Optional animation duration. Defaults to 0.1
///
- (void)showNavbarWithAnimated:(BOOL)animated duration:(NSTimeInterval)duration;
/// Stop observing the view and reset the navigation bar
/// \param showingNavbar If true the navbar is show, otherwise it remains in its current state. Defaults to <code>true</code>
///
- (void)stopFollowingScrollViewWithShowingNavbar:(BOOL)showingNavbar;
/// UIContentContainer protocol method.
/// Will show the navigation bar upon rotation or changes in the trait sizes.
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator> _Nonnull)coordinator;
/// UIGestureRecognizerDelegate function. Begin scrolling only if the direction is vertical (prevents conflicts with horizontal scroll views)
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer * _Nonnull)gestureRecognizer SWIFT_WARN_UNUSED_RESULT;
/// UIGestureRecognizerDelegate function. Enables the scrolling of both the content and the navigation bar
- (BOOL)gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer * _Nonnull)otherGestureRecognizer SWIFT_WARN_UNUSED_RESULT;
/// UIGestureRecognizerDelegate function. Only scrolls the navigation bar with the content when <code>scrollingEnabled</code> is true
- (BOOL)gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldReceiveTouch:(UITouch * _Nonnull)touch SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=5.0);
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end




/// Scrolling Navigation Bar delegate protocol
SWIFT_PROTOCOL("_TtP9SuperView37ScrollingNavigationControllerDelegate_")
@protocol ScrollingNavigationControllerDelegate <NSObject>
@optional
/// Called when the state of the navigation bar changes
/// \param controller the ScrollingNavigationController
///
/// \param state the new state
///
- (void)scrollingNavigationController:(ScrollingNavigationController * _Nonnull)controller didChangeState:(enum NavigationBarState)state;
/// Called when the state of the navigation bar is about to change
/// \param controller the ScrollingNavigationController
///
/// \param state the new state
///
- (void)scrollingNavigationController:(ScrollingNavigationController * _Nonnull)controller willChangeState:(enum NavigationBarState)state;
@end

@class UIScrollView;

/// A custom <code>UIViewController</code> that implements the base configuration.
SWIFT_CLASS("_TtC9SuperView33ScrollingNavigationViewController")
@interface ScrollingNavigationViewController : UIViewController <UINavigationControllerDelegate, UIScrollViewDelegate>
/// On appear calls <code>showNavbar()</code> by default
- (void)viewWillAppear:(BOOL)animated;
/// On disappear calls <code>stopFollowingScrollView()</code> to stop observing the current scroll view, and perform the tear down
- (void)viewWillDisappear:(BOOL)animated;
/// Calls <code>showNavbar()</code> when a <code>scrollToTop</code> is requested
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView * _Nonnull)scrollView SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIStoryboardSegue;

SWIFT_CLASS("_TtC9SuperView22SideMenuViewController")
@interface SideMenuViewController : UIViewController
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (void)viewDidLoad;
- (void)dismissSideMenuViewController;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end





@class SFSafariViewControllerConfiguration;

SWIFT_CLASS("_TtC9SuperView25SuperSafariViewController") SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SuperSafariViewController : SFSafariViewController
- (nonnull instancetype)initWithURL:(NSURL * _Nullable)url;
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL configuration:(SFSafariViewControllerConfiguration * _Nonnull)configuration OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=11.0);
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL entersReaderIfAvailable:(BOOL)entersReaderIfAvailable OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=11.0,deprecated=11.0);
@end


SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface SuperSafariViewController (SWIFT_EXTENSION(SuperView)) <SFSafariViewControllerDelegate>
- (void)safariViewControllerDidFinish:(SFSafariViewController * _Nonnull)controller;
@end

@class UIApplication;

SWIFT_CLASS("_TtC9SuperView9SuperView")
@interface SuperView : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) SuperView * _Nonnull shared;)
+ (SuperView * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
+ (void)configureWithApplication:(UIApplication * _Nonnull)application launchOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions plistURL:(NSURL * _Nullable)plistURL;
+ (void)show;
+ (BOOL)handleURLWithUrl:(NSURL * _Nonnull)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> * _Nonnull)options;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) NSBundle * _Nonnull bundle;)
+ (NSBundle * _Nonnull)bundle SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end




@interface SuperView (SWIFT_EXTENSION(SuperView))
+ (void)didBecomeActive;
@end

@class OSPermissionStateChanges;
@class OSSubscriptionStateChanges;

@interface SuperView (SWIFT_EXTENSION(SuperView)) <OSPermissionObserver, OSSubscriptionObserver>
- (void)onOSPermissionChanged:(OSPermissionStateChanges * _Null_unspecified)stateChanges;
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges * _Null_unspecified)stateChanges;
@end


SWIFT_CLASS("_TtC9SuperView29SuperViewNavigationController")
@interface SuperViewNavigationController : ScrollingNavigationController
- (nonnull instancetype)initWithUrl:(NSString * _Nonnull)url;
- (nonnull instancetype)init;
@property (nonatomic, readonly) UIStatusBarStyle preferredStatusBarStyle;
- (void)addDone;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=5.0);
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC9SuperView22SuperWebViewController")
@interface SuperWebViewController : ScrollingNavigationViewController <UIWebViewDelegate>
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end





@class GADRewardBasedVideoAd;

@interface SuperWebViewController (SWIFT_EXTENSION(SuperView)) <GADRewardBasedVideoAdDelegate>
- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd * _Nonnull)rewardBasedVideoAd;
@end



@class GADInterstitial;
@class GADRequestError;

@interface SuperWebViewController (SWIFT_EXTENSION(SuperView)) <GADInterstitialDelegate>
- (void)interstitialDidReceiveAd:(GADInterstitial * _Nonnull)ad;
- (void)interstitial:(GADInterstitial * _Nonnull)ad didFailToReceiveAdWithError:(GADRequestError * _Nonnull)error;
- (void)interstitialDidDismissScreen:(GADInterstitial * _Nonnull)ad;
@end

@class GADAdReward;
@class GADBannerView;

@interface SuperWebViewController (SWIFT_EXTENSION(SuperView)) <GADBannerViewDelegate>
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd * _Nonnull)rewardBasedVideoAd didRewardUserWithReward:(GADAdReward * _Nonnull)reward;
- (void)adViewDidReceiveAd:(GADBannerView * _Nonnull)bannerView;
- (void)adView:(GADBannerView * _Nonnull)bannerView didFailToReceiveAdWithError:(GADRequestError * _Nonnull)error;
@end



@class GCDWebServer;

@interface SuperWebViewController (SWIFT_EXTENSION(SuperView)) <GCDWebServerDelegate>
- (void)webServerDidStart:(GCDWebServer * _Nonnull)server;
- (void)webServerDidStop:(GCDWebServer * _Nonnull)server;
- (void)webServerDidConnect:(GCDWebServer * _Nonnull)server;
- (void)webServerDidDisconnect:(GCDWebServer * _Nonnull)server;
- (void)webServerDidUpdateNATPortMapping:(GCDWebServer * _Nonnull)server;
- (void)webServerDidCompleteBonjourRegistration:(GCDWebServer * _Nonnull)server;
@end

@class WKWebView;
@class WKNavigationResponse;
@class WKNavigationAction;
@class WKNavigation;

@interface SuperWebViewController (SWIFT_EXTENSION(SuperView)) <WKNavigationDelegate>
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^ _Nonnull)(WKNavigationResponsePolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^ _Nonnull)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView didFinishNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFailNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
@end


@interface SuperWebViewController (SWIFT_EXTENSION(SuperView))
@property (nonatomic, readonly) UIStatusBarStyle preferredStatusBarStyle;
@property (nonatomic, readonly) BOOL prefersStatusBarHidden;
@property (nonatomic, readonly) UIStatusBarAnimation preferredStatusBarUpdateAnimation;
@end


@interface SuperWebViewController (SWIFT_EXTENSION(SuperView))
- (void)observeValueForKeyPath:(NSString * _Nullable)keyPath ofObject:(id _Nullable)object change:(NSDictionary<NSKeyValueChangeKey, id> * _Nullable)change context:(void * _Nullable)context;
@end













@class WKWebViewConfiguration;

SWIFT_CLASS("_TtC9SuperView15WKCookieWebView")
@interface WKCookieWebView : WKWebView
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration * _Nonnull)configuration SWIFT_UNAVAILABLE;
@end



@class NSURLAuthenticationChallenge;
@class NSURLCredential;

@interface WKCookieWebView (SWIFT_EXTENSION(SuperView)) <WKNavigationDelegate>
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^ _Nonnull)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^ _Nonnull)(WKNavigationResponsePolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFailProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
- (void)webView:(WKWebView * _Nonnull)webView didCommitNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFinishNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFailNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
- (void)webView:(WKWebView * _Nonnull)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge completionHandler:(void (^ _Nonnull)(enum NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;
- (void)webViewWebContentProcessDidTerminate:(WKWebView * _Nonnull)webView SWIFT_AVAILABILITY(ios,introduced=9.0);
@end







#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
