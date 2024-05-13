//
//  AppDelegate.m
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import "AppDelegate.h"
#import <SDL2/SDL.h>


static void SDL_IdleTimerDisabledChanged(void *userdata, const char *name, const char *oldValue, const char *hint) {
    BOOL disable = (hint && *hint != '0');
    [UIApplication sharedApplication].idleTimerDisabled = disable;
}


// MARK: - AppDelegate
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSBundle *bundle = [NSBundle mainBundle];
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[bundle resourcePath]];
    
    SDL_AddHintCallback(SDL_HINT_IDLE_TIMER_DISABLED, SDL_IdleTimerDisabledChanged, NULL);
    SDL_SetMainReady();
    [self performSelector:@selector(postFinishLaunch) withObject:nil afterDelay:0.0];

    
    return YES;
}


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


// MARK: - SDL
+ (id)sharedAppDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (NSString *)getAppDelegateClassName {
    return @"AppDelegate";
}

- (void)postFinishLaunch {
    SDL_iPhoneSetEventPump(SDL_TRUE);
}

@end
