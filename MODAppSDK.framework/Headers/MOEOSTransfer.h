//
//  MOEOSTransfer.h
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOEOSTransfer : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *fromChainId;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *toChainId;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *tokenName;            //e.g. EOS
@property (nonatomic, copy) NSString *tokenContract;        //e.g. eosio.token
@property (nonatomic, assign) NSInteger tokenPrecision;     //e.g. 4
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *orderInfo;

@end
