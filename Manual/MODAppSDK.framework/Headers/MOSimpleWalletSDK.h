//
//  MODAppSDK.h
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MODapp;
@class MOEOSTransfer;
@class MOEOSTransactions;
@class MOCallbackResp;

typedef NS_ENUM(NSInteger, MOSimpleWalletCallbackResult) {
    MOSimpleWalletCallbackResultError = -1,
    MOSimpleWalletCallbackResultCancel = 0,
    MOSimpleWalletCallbackResultSuccess = 1,
    MOSimpleWalletCallbackResultFailed = 2
};
typedef void(^MOSimpleWalletCompletionBlock)(MOSimpleWalletCallbackResult result, id res, NSString *callbackURI);

@interface MOSimpleWalletSDK : NSObject

#pragma mark - Common
/**
 *  Register Dapp
 *
 *  @param dapp dapp's information
 *
 *  @return succsee
 */
+ (BOOL)registerSDKWithDApp:(MODapp *)dapp;

/**
 *  SimpleWallet Callback Handler
 *
 *  @param resultUrl callback open url
 *  @param completionBlock callback block
 *
 *  @return Whether sdk can handle
 */
+ (BOOL)handleCallbackWithResult:(NSURL *)resultUrl
                 completionBlock:(MOSimpleWalletCompletionBlock)completionBlock;

#pragma mark - EOS
/**
 *  Request EOS Authorization
 *
 *  @param description Reason of Requesting
 *  @param serverLoginURL dapp's server login API URL
 *  @param callbackURI dapp's callback URI
 *  @param completion completion block
 */
+ (void)requestEOSAuthorization:(NSString *)description
                 serverLoginURL:(NSString *)serverLoginURL
                    callbackURI:(NSString *)callbackURI
              completionHandler:(void (^ __nullable)(BOOL success))completion;

/**
 *  EOS Transfer
 *
 *  @param eosTransfer EOS Transfer
 *  @param callbackURI dapp's callback URI
 *  @param completion completion block
 */
+ (void)sendEOSTransferation:(MOEOSTransfer *)eosTransfer
                 callbackURI:(NSString *)callbackURI
           completionHandler:(void (^ __nullable)(BOOL success))completion;

@end
