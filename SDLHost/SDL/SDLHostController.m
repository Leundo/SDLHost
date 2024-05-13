//
//  SDLHostController.m
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <Foundation/Foundation.h>
#import "SDLHostController.h"
#import <SDL2/SDL.h>


static SDL_Texture* brush = 0;

void drawLine(SDL_Renderer *renderer, float startx, float starty, float dx, float dy) {

    float distance = SDL_sqrt(dx * dx + dy * dy);   /* length of line segment (pythagoras) */
    int iterations = distance / 5 + 1;       /* number of brush sprites to draw for the line */
    float dx_prime = dx / iterations;   /* x-shift per iteration */
    float dy_prime = dy / iterations;   /* y-shift per iteration */
    SDL_Rect dstRect;           /* rect to draw brush sprite into */
    float x;
    float y;
    int i;

    dstRect.w = 32;
    dstRect.h = 32;

    /* setup x and y for the location of the first sprite */
    x = startx - 32 / 2.0f;
    y = starty - 32 / 2.0f;

    /* draw a series of blots to form the line */
    for (i = 0; i < iterations; i++) {
        dstRect.x = x;
        dstRect.y = y;
        /* shift x and y for next sprite location */
        x += dx_prime;
        y += dy_prime;
        /* draw brush blot */
        SDL_RenderCopy(renderer, brush, NULL, &dstRect);
    }
}

void initializeTexture(SDL_Renderer *renderer) {
    SDL_Surface *bmp_surface;
    bmp_surface = SDL_LoadBMP("stroke.bmp");
    if (!bmp_surface) {
        NSLog(@"could not load stroke.bmp");
    }
    brush = SDL_CreateTextureFromSurface(renderer, bmp_surface);
    SDL_FreeSurface(bmp_surface);
    if (!brush) {
        NSLog(@"could not create brush texture");
    }
    /* additive blending -- laying strokes on top of eachother makes them brighter */
    SDL_SetTextureBlendMode(brush, SDL_BLENDMODE_ADD);
    /* set brush color (red) */
    SDL_SetTextureColorMod(brush, 255, 100, 100);
}

// MARK: - Controller


@implementation SDLHostController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        NSLog(@"Could not initialize SDL");
    }
    
    [self performSelector:@selector(postFinishViewDidLoad) withObject:nil afterDelay:0.0];
}

- (void)postFinishViewDidLoad {
    int x, y, dx, dy;
    int w, h;
    
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* target;
    
    window = SDL_Leundo_CreateViewBaseWindow(NULL, 16, 16, 320, 480, SDL_WINDOW_BORDERLESS | SDL_WINDOW_ALLOW_HIGHDPI, (__bridge void *)(self));
    [self.view addSubview:self.sdlView];
    self.sdlView.backgroundColor = [UIColor redColor];
    NSLog(@"%@", self.sdlView.backgroundColor);

    renderer = SDL_CreateRenderer(window, 0, 0);
    
    SDL_GetWindowSize(window, &w, &h);
    SDL_RenderSetLogicalSize(renderer, w, h);

    initializeTexture(renderer);
    
    target = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, w, h);
    SDL_SetRenderTarget(renderer, target);
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);
    SDL_SetRenderTarget(renderer, NULL);
    
    SDL_SetRenderTarget(renderer, target);
    drawLine(renderer, 200 - 100, 200 - 100, 100, 100);
    SDL_SetRenderTarget(renderer, NULL);
    SDL_RenderCopy(renderer, target, NULL, NULL);
    SDL_RenderPresent(renderer);
    
    NSLog(@"Done");
}

@end
