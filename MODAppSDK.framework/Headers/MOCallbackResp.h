//
//  MOCallbackResp.h
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MOFunctionType){
    MOFunctionTypeNone = 0,
    MOFunctionTypeAuthorize,
    MOFunctionTypeTransfer,
    MOFunctionTypePushTransactions,
    MOFunctionTypeSignature,
};

@interface MOCallbackResp : NSObject

@property (nonatomic, assign) NSInteger code;                   //0.succes, -1.cancel, != 0 failed
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign, readonly) MOFunctionType type;
@property (nonatomic, copy) NSDictionary *data;

@end
