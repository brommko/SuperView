//
//  GADRewardedAdBeta.h
//  Google Mobile Ads SDK
//
//  Copyright 2020 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <GoogleMobileAds/GADAdMetadata.h>
#import <GoogleMobileAds/GADAdReward.h>
#import <GoogleMobileAds/GADAdValue.h>
#import <GoogleMobileAds/GADFullScreenContentDelegate.h>
#import <GoogleMobileAds/GADRequest.h>
#import <GoogleMobileAds/GADResponseInfo.h>
#import <GoogleMobileAds/GADServerSideVerificationOptions.h>

@class GADRewardedAdBeta;

/// A block to be executed when the ad request operation completes. On success,
/// rewardedAd is non-nil and |error| is nil. On failure, rewardedAd is nil
/// and |error| is non-nil.
typedef void (^GADRewardedAdBetaLoadCompletionHandler)(GADRewardedAdBeta *_Nullable rewardedAd,
                                                       NSError *_Nullable error);

/// A rewarded ad. Rewarded ads are ads that users have the option of interacting with in exchange
/// for in-app rewards.
@interface GADRewardedAdBeta : NSObject <GADAdMetadataProvider, GADFullScreenPresentingAd>

/// The ad unit ID.
@property(nonatomic, readonly, nonnull) NSString *adUnitID;

/// Information about the ad response that returned the ad.
@property(nonatomic, readonly, nonnull) GADResponseInfo *responseInfo;

/// The reward earned by the user for interacting with the ad.
@property(nonatomic, readonly, nonnull) GADAdReward *adReward;

/// Options specified for server-side user reward verification. Must be set before presenting this
/// ad.
@property(nonatomic, copy, nullable)
    GADServerSideVerificationOptions *serverSideVerificationOptions;

/// Delegate for handling full screen content messages.
@property(nonatomic, weak, nullable) id<GADFullScreenContentDelegate> fullScreenContentDelegate;

/// Called when the ad is estimated to have earned money. Available for allowlisted accounts only.
@property(nonatomic, nullable, copy) GADPaidEventHandler paidEventHandler;

/// Loads a rewarded ad.
///
/// @param adUnitID An ad unit ID created in the AdMob or Ad Manager UI.
/// @param request An ad request object. If nil, a default ad request object is used.
/// @param completionHandler A handler to execute when the load operation finishes or times out.
+ (void)loadWithAdUnitID:(nonnull NSString *)adUnitID
                 request:(nullable GADRequest *)request
       completionHandler:(nonnull GADRewardedAdBetaLoadCompletionHandler)completionHandler;

/// Returns whether the rewarded ad can be presented from the provided root view
/// controller. Sets the error out parameter if the ad can't be presented. Must be called on the
/// main thread.
- (BOOL)canPresentFromRootViewController:(nonnull UIViewController *)rootViewController
                                   error:(NSError *_Nullable __autoreleasing *_Nullable)error;

/// Presents the rewarded ad. Must be called on the main thread.
///
/// @param rootViewController A view controller to present the ad.
/// @param userDidEarnRewardHandler A handler to execute when the user earns a reward.
- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController
             userDidEarnRewardHandler:(nonnull GADUserDidEarnRewardHandler)userDidEarnRewardHandler;

@end
