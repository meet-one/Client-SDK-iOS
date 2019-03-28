//
//  MOEOSRequest.h
//  MODAppSDK
//
//  Created by Rick on 2018/8/30.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOEOSTransactions : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *fromChainId;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, copy) NSDictionary *options;
@property (nonatomic, copy) NSString *transactionsInfo;

@end
