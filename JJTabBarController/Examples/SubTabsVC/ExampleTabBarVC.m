//
//  TabBarExampleVC.m
//  JJTabBarController
//
//  Created by João Jesus on 05/03/2014.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "ExampleTabBarVC.h"
#import "JJTabBarControllerLib.h"


@interface ExampleTabBarVC ()

@property (weak, nonatomic) IBOutlet JJTabBarView *horizontalTabBar;
@property (weak, nonatomic) IBOutlet JJTabBarView *verticalTabBar;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@property (nonatomic, strong) IBOutlet UIButton *btnTemplate;

@end

@implementation ExampleTabBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"TabBar";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    JJButtonSelectionBlock horizontalBlock = ^(UIButton *button, JJButtonEventType type ) {
        if (type == JJButtonEventSelect) {
     
            NSMutableArray *verticalViewsArray = [NSMutableArray array];
            for (int i=0; i<5; i++) {
                
                UIButton *tabButton = [[NSBundle mainBundle] loadNibNamed:@"ButtonTemplate" owner:self options:nil][0];
                [tabButton setTitle:[NSString stringWithFormat:@"Btn %d", i] forState:UIControlStateNormal];
                
                [tabButton addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
                    NSInteger horizontalIndex = self.horizontalTabBar.selectedIndex;
                    self.indexLabel.text = [NSString stringWithFormat:@"%ld - %ld", (long)horizontalIndex, (long)button.selectionIndex];
                } forEvent:JJButtonEventSelect];
                
                [verticalViewsArray addObject:tabButton];
                
                
                CGRect frame = tabButton.frame;
                
                // random change a frame
                //frame.size.height += arc4random_uniform(100);
                
                // fixed size
                frame.size.height = 80;
                
                tabButton.frame = frame;
            }
            self.verticalTabBar.childViews = verticalViewsArray;
            self.verticalTabBar.selectedIndex = 0;
            
        }else if (type == JJButtonEventReselect) {
            self.verticalTabBar.selectedIndex = 0;
        }
    };
    
    
    
    NSMutableArray *tabViewsArray = [NSMutableArray array];
    for (int i=0; i<10; i++) {
         UIButton *tabButton = [[NSBundle mainBundle] loadNibNamed:@"ButtonTemplate" owner:self options:nil][0];
        [tabButton setTitle:[NSString stringWithFormat:@"Btn %d", i] forState:UIControlStateNormal];
        [tabButton addBlockSelectionAction:horizontalBlock forEvent:JJButtonEventSelect];
        [tabButton addBlockSelectionAction:horizontalBlock forEvent:JJButtonEventReselect];
        [tabViewsArray addObject:tabButton];
    }
    
    self.verticalTabBar.alignment = JJBarViewAlignmentVertical;
    self.verticalTabBar.scrollEnabled = YES;
    self.verticalTabBar.autoResizeChilds = NO;
    self.verticalTabBar.centerTabBarOnSelect = YES;
    self.verticalTabBar.alwaysCenterTabBarOnSelect = YES;
    self.verticalTabBar.imageSeparator = [UIImage imageNamed:@"blueVerticalSeparator"];
    self.verticalTabBar.backgroundImage = [UIImage imageNamed:@"blueHorizontalBar"];
    
    self.horizontalTabBar.alignment = JJBarViewAlignmentHorizontal;
    [self.horizontalTabBar setScrollEnabledWithNumberOfChildsVisible:4.5];
    self.horizontalTabBar.childEdges = UIEdgeInsetsMake(4, 4, 4, 4);
    self.horizontalTabBar.centerTabBarOnSelect = YES;
    self.horizontalTabBar.imageSeparator = [UIImage imageNamed:@"blueHorizontalSeparator"];
    self.horizontalTabBar.backgroundImage = [UIImage imageNamed:@"blueHorizontalBar"];
    self.horizontalTabBar.childViews = tabViewsArray;
    self.horizontalTabBar.selectedIndex = 0;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
