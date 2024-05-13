//
//  SDL_leundo_uikitview.h
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>


@interface SDL_leundo_uikitview: UIView <UIPointerInteractionDelegate>

- (instancetype)initWithFrame:(CGRect)frame scale:(CGFloat)scale;

- (void)setViewController:(UIViewController*)viewController;

@end


SDL_MetalView UIKit_Leundo_Metal_CreateView(_THIS, SDL_Window* window, UIViewController* viewController);
void UIKit_Leundo_Metal_DestroyView(_THIS, SDL_MetalView view);
void *UIKit_Leundo_Metal_GetLayer(_THIS, SDL_MetalView view);
void UIKit_Leundo_Metal_GetDrawableSize(_THIS, SDL_Window * window, int * w, int * h);
