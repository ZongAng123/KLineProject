//
//  main.m
//  KLineProject
//
//  Created by 纵昂 on 2022/2/24.
//  纵昂简书:https://www.jianshu.com/u/88de89f5cc2c
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
