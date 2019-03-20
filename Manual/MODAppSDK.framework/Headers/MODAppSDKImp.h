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

typedef void(^MOCompletionBlock)(MOCallbackResp *resp, MODapp *meetone);

@interface MODAppSDK : NSObject

#pragma mark - Common
/**
 *  Register Dapp
 *
 *  @param dapp dapp's information
 *  @param dappScheme dapp's callback scheme
 *  @param redirectURLString dapp's callback redirectURLString
 *
 *  @return succsee
 */
+ (BOOL)registerWithDApp:(MODapp *)dapp
              dappScheme:(NSString *)dappScheme
       redirectURLString:(NSString *)redirectURLString;

/**
 *  MEET.ONE Callback Handler
 *
 *  @param resultUrl callback open url
 *  @param completionBlock callback block
 *
 *  @return Whether sdk can handle
 */
+ (BOOL)handleCallbackWithResult:(NSURL *)resultUrl
                 completionBlock:(MOCompletionBlock)completionBlock;

#pragma mark - EOS
/**
 *  Request EOS Authorization
 *
 *  @param description Reason of Requesting
 *  @param completion completion block
 */
+ (void)requestEOSAuthorization:(NSString *)description
              completionHandler:(void (^ __nullable)(BOOL success))completion;

/**
 *  Get EOS Account Info
 *
 *  @param description Reason of Requesting
 *  @param completion completion block
 */
+ (void)requestEOSAccountInfo:(NSString *)description
            completionHandler:(void (^ __nullable)(BOOL success))completion;

/**
 *  EOS Transfer
 *
 *  @param eosTransfer EOS Transfer
 *  @param completion completion block
 */
+ (void)sendEOSTransferation:(MOEOSTransfer *)eosTransfer
           completionHandler:(void (^ __nullable)(BOOL success))completion;

/**
 *  Push EOS Transactions
 *
 *  @param eosActions Standard EOS Actions
 *  @param completion completion block
 */
+ (void)pushEOSTransactions:(MOEOSTransactions *)eosActions
          completionHandler:(void (^ __nullable)(BOOL success))completion;

/**
 *  Request EOS Custom Signature
 *
 *  @param accountName request account name
 *  @param chainId request chain id
 *  @param description Reason of Requesting
 *  @param customData custom signature data
 *  @param completion completion block
 */
+ (void)requestEOSCustomSignature:(NSString *)accountName
                          chainId:(nullable NSString *)chainId
                      description:(NSString *)description
                       customData:(NSString *)customData
                completionHandler:(void (^ __nullable)(BOOL success))completion;

@end
