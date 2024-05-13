//
//  HomeController.m
//  SDLHost
//
//  Created by Leundo on 2024/05/13.
//

#import <Foundation/Foundation.h>
#import "HomeController.h"
#import "SDLHostController.h"


@interface HomeController ()

@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UIViewController* sdlHostController;

@end


@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sdlHostController = [[SDLHostController alloc] init];
    
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationItem.title = @"Home";
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    self.button.backgroundColor = [UIColor systemBlueColor];
    [self.button addTarget:self action:@selector(presentSDL:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    NSLog(@"%@", self.button.superview);
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:128];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:32];
    
    [self.view addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]];
}

- (IBAction)presentSDL:(id)sender forEvent:(UIEvent*)event {
    [self presentViewController:self.sdlHostController animated:YES completion:nil];
}


@end
