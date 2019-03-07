Client-SDK-iOS     
==============
iOS client SDK for DApps.Support MEET.ONE SDK & SimpleWallet SDK.     

## MEET.ONE SDK

### Features
- **Get EOS Account**: DApp can request EOS Authorization for an EOS Account.
- **EOS Transfer**: DApp can send EOS Transferation.
- **Push EOS Transactions**: DApp can push EOS Transactions.
- **Request EOS Custom Signature**: DApp can request EOS Custom Signature.

## SimpleWallet SDK

### Features
- **Get EOS Account**: DApp can request EOS Authorization for an EOS Account.
- **EOS Transfer**: DApp can send EOS Transferation.

## Installation

### CocoaPods

1. Add `pod 'MODAppSDK'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<MODAppSDK/MODAppSDK.h\>.

## MEET.ONE SDK Usage

### Step.1 - Register Your DApp


```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // other code
    
    //Create your dapp information
    MODapp *dapp = [MODapp new];
    dapp.name = @"MORE.ONE";
    dapp.icon = @"https://static.ethte.com/more/images/bigicon.png";
    dapp.version = @"1.1.0";
    dapp.dappDescription = @"MORE.ONE is the first airdrop “candy” distribution application focused on EOS.";
    dapp.uuID = @"6e76f5ef-86da-441f-9be8-f7bebef72f9f";
    
    //Register MEET.ONE SDK for your dapp
    [MODAppSDK registerWithDApp:dapp dappScheme:@"MeetOneSDKDemo" redirectURLString:@"https://more.one"];
    
    // other code
    
    return YES;
}
```

### Step.2 - Handle the Callback

#### Callback Data(CallbackResp Data)
```objc
@interface MOCallbackResp : NSObject

@property (nonatomic, assign) NSInteger code;                   //0.succes, -1.cancel, != 0 failed
@property (nonatomic, copy) NSString *message;                  //callback message
@property (nonatomic, assign, readonly) MOFunctionType type;    //callback function
@property (nonatomic, copy) NSDictionary *data;                 //data you want

@end
```

#### Get Callback

```objc
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {

    // other code
    
    //Handle MEET.ONE Callback
    BOOL meetoneCallback = [MODAppSDK handleCallbackWithResult:url completionBlock:^(MOCallbackResp *resp, MODapp *meetone) {
        NSInteger code = resp.code;
        NSString *message = resp.message;
        MOFunctionType type = resp.type;
        if (0 == code) { //success
            ;
        }
        NSLog(@"%@", message);  //print message
        switch (type) {
            case MOFunctionTypeNone:
                break;
            case MOFunctionTypeAuthorize:
                break;
            case MOFunctionTypeTransfer:
                break;
            case MOFunctionTypePushTransactions:
                break;
            default:
                break;
        }
    }];
    
    NSLog(@"success:%d", meetoneCallback);
    
    // other code
    
    return YES;
}
```

### Step.3 - Choose the function
#### 1.Request EOS Authorization

**API**

```objc
/**
 *  Request EOS Authorization
 *
 *  @param description Reason of Requesting
 *  @param completion completion block
 */
+ (void)requestEOSAuthorization:(NSString *)description
              completionHandler:(void (^ __nullable)(BOOL success))completion;
```

**Code Samples**

```objc
[MODAppSDK requestEOSAuthorization:@"EOS TO THE MOON !!!" completionHandler:^(BOOL success) {
        ;
}];
```

**CallbackResp Data**
* `NSDictionary` Account Info
    * `account`: `NSString` account name
    * `chainId`: `NSString` chainId
    * `publicKey`: `NSString` account publicKey
    * `permission`: `NSString` account permission
    * `currencyBalance`: `float` account eos balance
    * `signature`: `String` signature
    * `uuid`: `String` dapp uuid
    * `ref`: `String` default is "MEET.ONE"
    * `timestamp`: `String` sign timestamp

#### 2.EOS Transfer

**API**

```objc
/**
 *  EOS Transfer
 *
 *  @param eosTransfer EOS Transfer
 *  @param completion completion block
 */
+ (void)sendEOSTransferation:(MOEOSTransfer *)eosTransfer
           completionHandler:(void (^ __nullable)(BOOL success))completion;
```

**Code Samples**

```objc
//Create Transfer
MOEOSTransfer *transfer = [MOEOSTransfer new];
transfer.to = @"johntrump123";
transfer.toChainId = @"";
transfer.amount = 1;
transfer.tokenName = @"EOS";
transfer.tokenContract = @"eosio.token";
transfer.tokenPrecision = 4;
transfer.memo = @"Just for Test";
transfer.orderInfo = @"EOS TO THE MOON !!!";
    
//Send
[MODAppSDK sendEOSTransferation:transfer completionHandler:^(BOOL success) {
        ;
}];
```

**CallbackResp Data**  
* `NSDictionary` Returned data in chain
    * `transaction_id`:`NSString`  transaction_id


#### 3.Push EOS Transactions

**API**

```objc
/**
 *  Push EOS Transactions
 *
 *  @param eosActions Standard EOS Actions
 *  @param completion completion block
 */
+ (void)pushEOSTransactions:(MOEOSTransactions *)eosActions
          completionHandler:(void (^ __nullable)(BOOL success))completion;
```

**Code Samples**

```objc
//Create Transactions
MOEOSTransactions *transactions = [MOEOSTransactions new];
transactions.from = @"johntrump123";
transactions.chainId = @"";
transactions.actions = @[@{@"account":@"eosio.token",@"name":@"transfer",@"authorization":@[@{@"actor":@"johntrump123",@"permission":@"owner"}],@"data":@{@"from":@"johntrump123",@"to":@"wujunchuan12",@"quantity":@"0.0001 EOS",@"memo":@"sdk test"}}];
transactions.options = @{@"broadcast":@(YES)};
transactions.transactionsInfo = @"EOS TO THE MOON !!!";

//Push
[MODAppSDK pushEOSTransactions:transactions completionHandler:^(BOOL success) {
    ;
}];
```

**CallbackResp Data**  
* `NSDictionary` Returned data in chain
    * `transaction_id`:`NSString`  transaction_id


#### 4.Request EOS Custom Signature

**API**

```objc
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
```

**Code Samples**

```objc
//Request EOS Custom Signature
[MODAppSDK requestEOSCustomSignature:@"johntrump123"
                             chainId:nil
                         description:@"EOS TO THE MOON !!!"
                          customData:@"for test"
                   completionHandler:^(BOOL success) {
        ;
}];
```

**CallbackResp Data**  
* `NSDictionary` Signature data in chain
    * `account`: `NSString` account name
    * `chainId`: `NSString` chainId
    * `permission`: `NSString` account permission
    * `signature`:`NSString`  signature


#### 5.Request EOS AccountInfo

**API**

```objc
/**
 *  Get EOS Account Info
 *
 *  @param description Reason of Requesting
 *  @param completion completion block
 */
+ (void)requestEOSAccountInfo:(NSString *)description
            completionHandler:(void (^ __nullable)(BOOL success))completion;
```

**Code Samples**

```objc
[MODAppSDK requestEOSAccountInfo:@"EOS TO THE MOON !!!" completionHandler:^(BOOL success) {
        ;
}];
```

**CallbackResp Data**
* `NSDictionary` Account Info
    * `account`: `NSString` account name
    * `chainId`: `NSString` chainId
    * `publicKey`: `NSString` account publicKey
    * `permission`: `NSString` account permission
    * `currencyBalance`: `float` account eos balance

    
## SimpleWallet SDK Usage

### Step.1 - Register Your DApp


```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // other code
    
    //Create your dapp information
    MODapp *dapp = [MODapp new];
    dapp.name = @"MORE.ONE";
    dapp.icon = @"https://static.ethte.com/more/images/bigicon.png";
    dapp.version = @"1.1.0";
    dapp.dappDescription = @"MORE.ONE is the first airdrop “candy” distribution application focused on EOS.";
    dapp.uuID = @"6e76f5ef-86da-441f-9be8-f7bebef72f9f";
    
    //Register SimpleWallet SDK for your dapp
    [MOSimpleWalletSDK registerSDKWithDApp:dapp];
    
    // other code
    
    return YES;
}
```

### Step.2 - Handle the Callback

#### Get Callback

```objc
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {

    // other code
    
    //Handle SimpleWallet Callback
        BOOL simpleWalletCallback =         [MOSimpleWalletSDK handleCallbackWithResult:url completionBlock:^(MOSimpleWalletCallbackResult result, id res, NSString *callbackURI) {
            NSLog(@"callbackURI:%@, res:%@", callbackURI, res);  //print message
            switch (result) {
                case MOSimpleWalletCallbackResultError:
                    ;
                    break;
                case MOSimpleWalletCallbackResultSuccess:
                    break;
                case MOSimpleWalletCallbackResultFailed:
                    ;
                    break;
                case MOSimpleWalletCallbackResultCancel:
                    ;
                    break;
                default:
                    break;
            }
        }];
    
    // other code
    
    return YES;
}
```


### Step.3 - Choose the function
#### 1.Request EOS Authorization

**API**

```objc
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
```

**Code Samples**

```objc
[MOSimpleWalletSDK requestEOSAuthorization:@"SimpleWallet" serverLoginURL:@"https://demo/api/login.php" callbackURI:@"MeetOneSDKDemo://more.one?action=login" completionHandler:^(BOOL success) {
        ;
}];
```

**res Data**
* `NSDictionary` Account Info or nil

#### 2.EOS Transfer

**API**

```objc
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
```

**Code Samples**

```objc
//Create Transfer
MOEOSTransfer *transfer = [MOEOSTransfer new];
transfer.to = @"johntrump123";
transfer.amount = 1;
transfer.tokenName = @"EOS";
transfer.tokenContract = @"eosio.token";
transfer.tokenPrecision = 4;
transfer.memo = @"Just for Test";
transfer.orderInfo = @"EOS TO THE MOON !!!";
    
//Send
[MOSimpleWalletSDK sendEOSTransferation:transfer callbackURI:@"MeetOneSDKDemo://more.one?action=transfer" completionHandler:^(BOOL success) {
        ;
}];
```

**res Data**  
* `NSDictionary` Returned data in chain
    * `txID`:`NSString`  transaction_id
