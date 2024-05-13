//
//  SDL_leundo_uikitview.m
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <Foundation/Foundation.h>
#import "SDL_leundo_uikitview.h"


@implementation SDL_leundo_uikitview {
    
}

- (void) setViewController:(UIViewController*)viewController {
    [viewController setValue:self forKey:@"sdlView"];
}


@end
