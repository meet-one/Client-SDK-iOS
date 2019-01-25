//
//  ViewController.m
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <YYModel/YYModel.h>
#import <MODAppSDK/MODAppSDK.h>
#import "MeetOneViewController.h"

@interface MeetOneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusForTransfering;
@property (weak, nonatomic) IBOutlet UILabel *statusForPushing;
@property (weak, nonatomic) IBOutlet UILabel *statusForSignature;

@end

@implementation MeetOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak MeetOneViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOFunctionTypeAuthorize" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOCallbackResp *resp = note.object;
        if (0 == resp.code) {
            weakSelf.accountNameLabel.text = resp.data[@"account"];
        } else {
            weakSelf.accountNameLabel.text = @"faied!";
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOFunctionTypeTransfer" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOCallbackResp *resp = note.object;
        if (0 == resp.code) {
            weakSelf.statusForTransfering.text = @"success!";
        } else {
            weakSelf.statusForTransfering.text = @"faied!";
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOFunctionTypePushTransactions" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOCallbackResp *resp = note.object;
        if (0 == resp.code) {
            weakSelf.statusForPushing.text = @"success!";
        } else {
            weakSelf.statusForPushing.text = @"faied!";
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOFunctionTypeSignature" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOCallbackResp *resp = note.object;
        if (0 == resp.code) {
            weakSelf.statusForSignature.text = @"success!";
        } else {
            weakSelf.statusForSignature.text = @"faied!";
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getEOSAccount:(id)sender {
    [MODAppSDK requestEOSAuthorization:@"EOS TO THE MOON" completionHandler:^(BOOL success) {
        ;
    }];
}

- (IBAction)transfer:(id)sender {
    //Create transfer
    MOEOSTransfer *transfer = [MOEOSTransfer new];
    transfer.from = @"johntrump123";
    transfer.fromChainId = @"";
    transfer.to = @"wujunchuan12";
    transfer.toChainId = @"";
    transfer.amount = @"0.0001";
    transfer.tokenName = @"EOS";
    transfer.tokenContract = @"eosio.token";
    transfer.tokenPrecision = 4;
    transfer.memo = @"Just for Test";
    transfer.orderInfo = @"EOS TO THE MOON";
    
    //Send
    [MODAppSDK sendEOSTransferation:transfer completionHandler:^(BOOL success) {
        ;
    }];
}

- (IBAction)pushActions:(id)sender {
    MOEOSTransactions *transactions = [MOEOSTransactions new];
    transactions.from = @"johntrump123";
    transactions.fromChainId = @"";
    transactions.actions = @[@{@"account":@"eosio.token",@"name":@"transfer",@"authorization":@[@{@"actor":@"johntrump123",@"permission":@"owner"}],@"data":@{@"from":@"johntrump123",@"to":@"wujunchuan12",@"quantity":@"0.0001 EOS",@"memo":@"sdk test"}}];
    transactions.options = @{@"broadcast":@(YES)};
    transactions.transactionsInfo = @"EOS TO THE MOON !!!";
    [MODAppSDK pushEOSTransactions:transactions completionHandler:^(BOOL success) {
        ;
    }];
}

- (IBAction)requestCustomSignature:(id)sender {
    [MODAppSDK requestEOSCustomSignature:@"johntrump123"
                                 chainId:nil
                             description:@"EOS TO THE MOON !!!"
                              customData:@"for test" completionHandler:^(BOOL success) {
        ;
    }];
}


@end
