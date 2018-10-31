//
//  AppDelegate.m
//  MeetOneSDK
//
//  Created by 傅福斌 on 2018/8/28.
//  Copyright © 2018年 MEET.ONE. All rights reserved.
//

#import <MODAppSDK/MODAppSDK.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Create your dapp information
    MODapp *dapp = [MODapp new];
    dapp.name = @"MORE.ONE";
    dapp.icon = @"https://static.ethte.com/more/images/bigicon.png";
    dapp.version = @"1.1.0";
    dapp.dappDescription = @"MORE.ONE is the first airdrop “candy” distribution application focused on EOS.";
    dapp.uuID = @"6e76f5ef-86da-441f-9be8-f7bebef72f9f";
    
    //Register MEET.ONE SDK for your dapp
    [MODAppSDK registerWithDApp:dapp dappScheme:@"MeetOneSDKDemo" redirectURLString:@"https://more.one"];
    //Register SimpleWallet SDK for your dapp
    [MOSimpleWalletSDK registerSDKWithDApp:dapp];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
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
                ;
                break;
            case MOFunctionTypeAuthorize:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOFunctionTypeAuthorize" object:resp];
                break;
            case MOFunctionTypeTransfer:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOFunctionTypeTransfer" object:resp];
                break;
            case MOFunctionTypePushTransactions:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOFunctionTypePushTransactions" object:resp];
                break;
            case MOFunctionTypeSignature:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOFunctionTypeSignature" object:resp];
                break;
            default:
                break;
        }
    }];
    
    if (!meetoneCallback) {
        //Handle SimpleWallet Callback
        BOOL simpleWalletCallback = [MOSimpleWalletSDK handleCallbackWithResult:url completionBlock:^(MOSimpleWalletCallbackResult result, id res, NSString *callbackURI) {
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
            if ([callbackURI containsString:@"MeetOneSDKDemo://more.one?action=login"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOSimpleWalletAuthorize" object:@(result)];
            } else if ([callbackURI containsString:@"MeetOneSDKDemo://more.one?action=transfer"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MOSimpleWalletTransfer" object:@(result)];
            }
        }];
    }
    
    NSLog(@"success:%d", meetoneCallback);
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    [options setObject:sourceApplication forKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"];
    [options setObject:annotation forKey:@"UIApplicationOpenURLOptionsAnnotationKey"];
    return [self application:application openURL:url options:options];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self application:application openURL:url options:@{}];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MeetOneSDK"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
