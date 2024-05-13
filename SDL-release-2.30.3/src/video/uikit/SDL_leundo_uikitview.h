//
//  SDL_leundo_uikitview.h
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <UIKit/UIKit.h>

@interface SDL_leundo_uikitview: UIView <UIPointerInteractionDelegate>

- (void) setViewController:(UIViewController*)viewController;

@end


