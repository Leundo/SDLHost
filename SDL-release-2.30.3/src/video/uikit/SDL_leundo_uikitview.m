//
//  SDL_leundo_uikitview.m
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#include "../../SDL_internal.h"
#include "SDL_syswm.h"
#include "../SDL_sysvideo.h"
#import "SDL_uikitwindow.h"

#import <Foundation/Foundation.h>
#import "SDL_leundo_uikitview.h"


@implementation SDL_leundo_uikitview {
    
}

+ (Class)layerClass {
    return [CAMetalLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame scale:(CGFloat)scale {
    if ((self = [super initWithFrame:frame])) {
        self.tag = SDL_METALVIEW_TAG;
        self.layer.contentsScale = scale;
        [self updateDrawableSize];
    }
    return self;
}

- (void)updateDrawableSize {
    CGSize size = self.bounds.size;
    size.width *= self.layer.contentsScale;
    size.height *= self.layer.contentsScale;
    ((CAMetalLayer*)self.layer).drawableSize = size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateDrawableSize];
}

- (void) setViewController:(UIViewController*)viewController {
    [viewController setValue:self forKey:@"sdlView"];
}

@end


void* UIKit_Leundo_Metal_CreateView(_THIS, SDL_Window* window, UIViewController* viewController) {
    @autoreleasepool {
        CGFloat scale = [[UIApplication sharedApplication] keyWindow].screen.nativeScale;
        SDL_leundo_uikitview *uiview = [[SDL_leundo_uikitview alloc] initWithFrame:CGRectMake(window->x, window->y, window->w, window->h) scale: scale];
        
        if (uiview == nil) {
            SDL_OutOfMemory();
            return NULL;
        }
        [uiview setViewController:viewController];

        return (__bridge void*)(uiview);
    }
}

void UIKit_Leundo_Metal_DestroyView(_THIS, SDL_MetalView view) {
    @autoreleasepool {
        
    }
}

void *UIKit_Leundo_Metal_GetLayer(_THIS, SDL_MetalView view) {
    @autoreleasepool {
        SDL_leundo_uikitview *uiview = (__bridge SDL_leundo_uikitview *)view;
        return (__bridge void *)uiview.layer;
    }
}


void UIKit_Leundo_Metal_GetDrawableSize(_THIS, SDL_Window * window, int * w, int * h) {
    @autoreleasepool {
        SDL_WindowData *data = (__bridge SDL_WindowData *)window->driverdata;
        SDL_leundo_uikitview *view = (SDL_leundo_uikitview*)data.leundo_uiview;
        if (view) {
            CAMetalLayer *layer = (CAMetalLayer*)view.layer;
            assert(layer != NULL);
            if (w) {
                *w = layer.drawableSize.width;
            }
            if (h) {
                *h = layer.drawableSize.height;
            }
        } else {
            SDL_GetWindowSize(window, w, h);
        }
    }
}
