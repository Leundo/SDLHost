//
//  AppDelegate.h
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


// MARK: - SDL
+ (id)sharedAppDelegate;
+ (NSString *)getAppDelegateClassName;


@end

