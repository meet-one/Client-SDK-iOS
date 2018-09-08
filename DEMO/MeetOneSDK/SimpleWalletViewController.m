//
//  ViewController.m
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <YYModel/YYModel.h>
#import <MODAppSDK/MODAppSDK.h>
#import "SimpleWalletViewController.h"

@interface SimpleWalletViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusForTransfering;

@end

@implementation SimpleWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak SimpleWalletViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOSimpleWalletAuthorize" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOSimpleWalletCallbackResult result = [note.object integerValue];
        if (MOSimpleWalletCallbackResultSuccess == result) {
            weakSelf.accountNameLabel.text = @"success!";
        } else {
            weakSelf.accountNameLabel.text = @"faied!";
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MOSimpleWalletTransfer" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        MOSimpleWalletCallbackResult result = [note.object integerValue];
        if (MOSimpleWalletCallbackResultSuccess == result) {
            weakSelf.statusForTransfering.text = @"success!";
        } else {
            weakSelf.statusForTransfering.text = @"faied!";
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getEOSAccount:(id)sender {
    [MOSimpleWalletSDK requestEOSAuthorization:@"SimpleWallet" serverLoginURL:nil callbackURI:@"MeetOneSDKDemo://more.one?action=login" completionHandler:^(BOOL success) {
        ;
    }];
}

- (IBAction)transfer:(id)sender {
    //Create transfer
    MOEOSTransfer *transfer = [MOEOSTransfer new];
    transfer.from = @"johntrump123";
    transfer.to = @"wujunchuan12";
    transfer.amount = 0.0001;
    transfer.tokenName = @"EOS";
    transfer.tokenContract = @"eosio.token";
    transfer.tokenPrecision = 4;
    transfer.memo = @"Just for Test";
    transfer.orderInfo = @"SimpleWallet";
    
    //Send
    [MOSimpleWalletSDK sendEOSTransferation:transfer callbackURI:@"MeetOneSDKDemo://more.one?action=transfer" completionHandler:^(BOOL success) {
        ;
    }];
}


@end
