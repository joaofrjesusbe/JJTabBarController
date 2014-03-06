//
//  ExampleTabbarConfigVCViewController.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleTabbarConfigVC.h"
#import "JJTabBarControllerLib.h"
#import "CheckBoxValue.h"
#import "ExampleSettings.h"

@interface ExampleTabbarConfigVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segOrientation;

@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue1;
@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue2;
@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue3;
@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue4;
@property (strong, nonatomic) JJButtonMatrix *buttonMatrixScrollPolicy;

@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue5;
@property (weak, nonatomic) IBOutlet UIView *containerCheckBoxValue6;
@property (strong, nonatomic) JJButtonMatrix *buttonMatrixSelectPolicy;

@end

@implementation ExampleTabbarConfigVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Config";
    }
    return self;
}

#pragma mark - Converter Orientation

- (JJTabBarDock)dockingForIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return JJTabBarDockTop;
        case 1:
            return JJTabBarDockLeft;
        case 2:
            return JJTabBarDockBottom;
        case 3:
            return JJTabBarDockRight;
            
        default:
            return JJTabBarDockBottom;
    }
}

- (NSInteger)indexForDocking:(NSInteger)index {
    switch (index) {
        case JJTabBarDockTop:
            return 0;
        case JJTabBarDockLeft:
            return 1;
        case JJTabBarDockBottom:
            return 2;
        case JJTabBarDockRight:
            return 3;
            
        default:
            return 2;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CheckBoxValue *checkBox;
    self.buttonMatrixScrollPolicy = [[JJButtonMatrix alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    
    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithHiddenValueAndText:@"No Scroll"];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue1 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [ExampleSettings sharedSettings].scrollPolicyIndex = self.buttonMatrixScrollPolicy.selectedIndex;
        self.jjTabBarController.tabBar.scrollEnabled = NO;
    } forEvent:JJButtonEventSelect];
    
    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithHiddenValueAndText:@"Simple Scroll"];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue2 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [ExampleSettings sharedSettings].scrollPolicyIndex = self.buttonMatrixScrollPolicy.selectedIndex;
        self.jjTabBarController.tabBar.scrollEnabled = YES;
    } forEvent:JJButtonEventSelect];

    CGFloat childSize = 120.0f;
    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithText:@"Fixed Box Scroll" value:childSize];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue3 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [ExampleSettings sharedSettings].scrollPolicyIndex = self.buttonMatrixScrollPolicy.selectedIndex;
        [self.jjTabBarController.tabBar setScrollEnabledWithChildSize:childSize];
    } forEvent:JJButtonEventSelect];

    CGFloat childItems = 3.5;
    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithText:@"Items Box Scroll" value:childItems];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue4 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [ExampleSettings sharedSettings].scrollPolicyIndex = self.buttonMatrixScrollPolicy.selectedIndex;
        [self.jjTabBarController.tabBar setScrollEnabledWithNumberOfChildsVisible:childItems];
    } forEvent:JJButtonEventSelect];

    self.buttonMatrixScrollPolicy.buttonsArray = array;
    
    
    self.buttonMatrixSelectPolicy = [[JJButtonMatrix alloc] init];
    self.buttonMatrixSelectPolicy.allowMultipleSelection = YES;
    array = [NSMutableArray array];
    
    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithHiddenValueAndText:@"Selected Item always center"];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue5 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [self.jjTabBarController.tabBar setAlwaysCenterTabBarOnSelect:YES];
    } forEvent:JJButtonEventSelect];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [self.jjTabBarController.tabBar setAlwaysCenterTabBarOnSelect:NO];
    } forEvent:JJButtonEventDeselect];

    checkBox = [CheckBoxValue checkBoxValue];
    [checkBox setupCheckBoxWithHiddenValueAndText:@"Selected Item centered"];
    [array addObject:checkBox.checkButton];
    [self.containerCheckBoxValue6 addSubview:checkBox];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [self.jjTabBarController.tabBar setCenterTabBarOnSelect:YES];
    } forEvent:JJButtonEventSelect];
    [checkBox.checkButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [self.jjTabBarController.tabBar setCenterTabBarOnSelect:NO];
    } forEvent:JJButtonEventDeselect];
    
    self.buttonMatrixSelectPolicy.buttonsArray = array;
    
    self.scrollView.contentSize = self.scrollContentView.frame.size;

}

- (void)viewWillAppear:(BOOL)animated {
    self.segOrientation.selectedSegmentIndex = [self indexForDocking:self.jjTabBarController.tabBarDock];
    self.buttonMatrixScrollPolicy.selectedIndex = [ExampleSettings sharedSettings].scrollPolicyIndex;
}

- (IBAction)changeOrientation:(id)sender {
    self.jjTabBarController.tabBarDock = [self dockingForIndex:self.segOrientation.selectedSegmentIndex];
}

@end
