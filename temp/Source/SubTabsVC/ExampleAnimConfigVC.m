//
//  BarViewExampleVC.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleAnimConfigVC.h"
#import "JJTabBarControllerLib.h"
#import "ExampleSettings.h"

@interface ExampleAnimConfigVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segAnimHiddenTabbar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segAnimDefaultTrans;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segAnimOtherTrans;

@end

@implementation ExampleAnimConfigVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Anim";
    }
    return self;
}

#pragma mark - Converter Animation

- (NSInteger)indexForAnimation:(JJTabBarAnimation)animation {
    switch (animation) {
        case JJTabBarAnimationCrossDissolve:
            return 1;

        case JJTabBarAnimationSlide:
            return 2;

        default:
            return 0;
    }
}

- (JJTabBarAnimation)animationForIndex:(NSInteger)index {
    switch (index) {
        case 1:
            return JJTabBarAnimationCrossDissolve;
            
        case 2:
            return JJTabBarAnimationSlide;
            
        default:
            return JJTabBarAnimationNone;
    }
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.segAnimDefaultTrans.selectedSegmentIndex = [self indexForAnimation:[ExampleSettings sharedSettings].defaultVCTransition];
    self.segAnimOtherTrans.selectedSegmentIndex = [self indexForAnimation:[ExampleSettings sharedSettings].nonDefaultVCTransition];
    self.segAnimHiddenTabbar.selectedSegmentIndex = [self indexForAnimation:[ExampleSettings sharedSettings].hiddenTabBar];
}

#pragma mark - IBActions

- (IBAction)changeAnimHiddenTabbar:(id)sender {
    [ExampleSettings sharedSettings].hiddenTabBar = [self animationForIndex:self.segAnimHiddenTabbar.selectedSegmentIndex];
}

- (IBAction)changeAnimDefaultTrans:(id)sender {
    [ExampleSettings sharedSettings].defaultVCTransition = [self animationForIndex:self.segAnimDefaultTrans.selectedSegmentIndex];
}

- (IBAction)changeAnimOtherTrans:(id)sender {
    [ExampleSettings sharedSettings].nonDefaultVCTransition = [self animationForIndex:self.segAnimOtherTrans.selectedSegmentIndex];
}

@end
