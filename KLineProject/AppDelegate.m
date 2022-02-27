//
//  AppDelegate.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/24.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CustNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor =[UIColor whiteColor];
    ViewController *controll = [[ViewController alloc]init];
    CustNavigationController *navi = [[CustNavigationController alloc]initWithRootViewController:controll];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
