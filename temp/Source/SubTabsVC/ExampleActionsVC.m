//
//  MoreViewVC.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleActionsVC.h"
#import "JJTabBarControllerLib.h"
#import "ExampleTabBarVC.h"
#import "ExampleAnimConfigVC.h"
#import "ExampleSettings.h"


@interface ExampleActionsVC ()

@property(nonatomic,strong) NSArray *backupVCs;
@property(nonatomic,strong) UIButton *backupButton;
@property(nonatomic,assign) BOOL usingOriginalVCs;

@end

@implementation ExampleActionsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Actions";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.usingOriginalVCs = YES;
}

- (IBAction)changeTabByCode:(id)sender {
    
    [self.jjTabBarController setSelectedTabBarIndex:0 animation:[ExampleSettings sharedSettings].nonDefaultVCTransition completion:nil];
}

- (IBAction)changeVCsByCode:(id)sender {
    
    if (self.usingOriginalVCs) {
        
        ExampleTabBarVC *tabBar = [[ExampleTabBarVC alloc] initWithNibName:nil bundle:nil];
        
        ExampleAnimConfigVC *config = [[ExampleAnimConfigVC alloc] initWithNibName:nil bundle:nil];
        
        // remove our custom button so a default delegate is created
        self.backupButton = self.jjTabBarButton;
        self.jjTabBarButton = nil;
        
        self.backupVCs = self.jjTabBarController.tabBarChilds;
        self.usingOriginalVCs = NO;
        
        NSArray * childViewControllers = @[ tabBar, self, config];
        
        [self.jjTabBarController setTabBarChilds:childViewControllers animation:[ExampleSettings sharedSettings].nonDefaultVCTransition completion:nil];
        
    } else {

        self.jjTabBarButton = self.backupButton;
        self.usingOriginalVCs = YES;
        
        [self.jjTabBarController setTabBarChilds:self.backupVCs animation:[ExampleSettings sharedSettings].nonDefaultVCTransition completion:nil];

    }
}


- (IBAction)toggleHiddenTabBar:(id)sender {
    
    [self.jjTabBarController setHiddenTabBar:!self.jjTabBarController.hiddenTabBar animation:[ExampleSettings sharedSettings].hiddenTabBar completion:nil];
}

@end
