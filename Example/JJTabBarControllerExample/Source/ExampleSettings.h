//
//  SettingsExample.h
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTabBarControllerLib.h"

@interface ExampleSettings : NSObject

+ (instancetype)sharedSettings;

- (void)initializeDefaultsWithTabBarController:(JJTabBarController *)tabBarController;

@property(nonatomic, readonly) JJTabBarController *tabBarController;

@property(nonatomic, assign) JJTabBarAnimation hiddenTabBar;
@property(nonatomic, assign) JJTabBarAnimation defaultVCTransition;
@property(nonatomic, assign) JJTabBarAnimation nonDefaultVCTransition;

@property(nonatomic, assign) NSInteger scrollPolicyIndex;

@end
