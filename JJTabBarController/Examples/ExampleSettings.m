//
//  SettingsExample.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleSettings.h"

@interface ExampleSettings ()

@property(nonatomic, readwrite, strong) JJTabBarController *tabBarController;

@end


@implementation ExampleSettings

+ (instancetype)sharedSettings {
    
    static ExampleSettings *_sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSettings = [[ExampleSettings alloc] init];
    });
    
    return _sharedSettings;
}

- (void)initializeDefaultsWithTabBarController:(JJTabBarController *)tabBarController {
    self.tabBarController = tabBarController;
    
    self.hiddenTabBar = JJTabBarAnimationSlide;
    self.defaultVCTransition = JJTabBarAnimationCrossDissolve;
    self.nonDefaultVCTransition = JJTabBarAnimationNone;
    
    self.scrollPolicyIndex = 0;
}

@dynamic defaultVCTransition;
- (JJTabBarAnimation)defaultVCTransition {
    return self.tabBarController.defaultSelectedControllerAnimation;
}

-(void)setDefaultVCTransition:(JJTabBarAnimation)defaultVCTransition {
    self.tabBarController.defaultSelectedControllerAnimation = defaultVCTransition;
}

@end
