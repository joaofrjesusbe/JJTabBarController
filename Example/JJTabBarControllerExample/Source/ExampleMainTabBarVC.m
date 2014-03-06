//
//  TabBarControllerExampleVC.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleMainTabBarVC.h"
#import "ExampleTabBarVC.h"
#import "ExampleAnimConfigVC.h"
#import "ExampleActionsVC.h"
#import "ExampleTabbarConfigVC.h"
#import "JJTabBarControllerLib.h"
#import "ExampleSettings.h"

@interface ExampleMainTabBarVC () <JJTabBarControllerDelegate>

@property (nonatomic,strong) JJTabBarController *tabBarController;

@end

@implementation ExampleMainTabBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    JJTabBarView *tabBarView = [[JJTabBarView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    tabBarView.backgroundImage = [UIImage imageNamed:@"blackHorizontalBar"];

    ExampleTabBarVC *tabBar = [[ExampleTabBarVC alloc] initWithNibName:nil bundle:nil];
    tabBar.jjTabBarButton = [[NSBundle mainBundle] loadNibNamed:@"MainButtonTemplate" owner:self options:nil][0];
    
    ExampleAnimConfigVC *animConfig = [[ExampleAnimConfigVC alloc] initWithNibName:nil bundle:nil];
    animConfig.jjTabBarButton = [[NSBundle mainBundle] loadNibNamed:@"MainButtonTemplate" owner:self options:nil][0];

    ExampleTabbarConfigVC *tabbarConfig = [[ExampleTabbarConfigVC alloc] initWithNibName:nil bundle:nil];
    tabbarConfig.jjTabBarButton = [[NSBundle mainBundle] loadNibNamed:@"MainButtonTemplate" owner:self options:nil][0];

    ExampleActionsVC *actions = [[ExampleActionsVC alloc] initWithNibName:nil bundle:nil];
    actions.jjTabBarButton = [[NSBundle mainBundle] loadNibNamed:@"MainButtonTemplate" owner:self options:nil][0];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MoreStoryboard" bundle:nil];
    UIViewController *more = [sb instantiateInitialViewController];
    more.jjTabBarButton = [[NSBundle mainBundle] loadNibNamed:@"MainButtonTemplate" owner:self options:nil][0];
    
    _tabBarController = [[JJTabBarController alloc] initWithTabBar:tabBarView andDockPosition:JJTabBarDockBottom];
    _tabBarController.delegate = self;
    _tabBarController.tabBarChilds = @[tabBar, animConfig, tabbarConfig, actions, more];
    _tabBarController.selectedTabBarIndex = 1;
    [self addChildViewController:_tabBarController];
    [self.view addSubview:_tabBarController.view];
    [_tabBarController didMoveToParentViewController:self];
    
    ExampleSettings *settings = [ExampleSettings sharedSettings];
    [settings initializeDefaultsWithTabBarController:_tabBarController];
}

#pragma mark - JTabBarControllerDelegate

- (UIButton *)tabBarController:(JJTabBarController *)tabBarController tabBarButtonForTabBarChild:(UIViewController *)childViewController forIndex:(NSInteger)index {
    
    // this will only execute if the childViewController do not provide a jTabBarButton
    return [[NSBundle mainBundle] loadNibNamed:@"AltMainButtonTemplate" owner:self options:nil][0];;
}

@end
