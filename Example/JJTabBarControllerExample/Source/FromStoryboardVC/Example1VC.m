//
//  Example1VC.m
//  JJTabBarControllerExample
//
//  Created by Joao Jesus on 16/06/14.
//  Copyright (c) 2014 João Jesus. All rights reserved.
//

#import "Example1VC.h"
#import "JJTabBarControllerLib.h"

@interface Example1VC ()

@property (weak, nonatomic) IBOutlet JJBarView *barView;

@end

@implementation Example1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barView.alignment = JJBarViewAlignmentHorizontalLeft;
    self.barView.autoResizeChilds = NO;
}

- (IBAction)alignmentChange:(UISegmentedControl *)sender {
}

- (IBAction)countChange:(UIStepper *)sender {
    NSInteger newCount = sender.value;
    NSInteger oldCount = self.barView.childViews.count;
    if (newCount > oldCount) {
        NSMutableArray *copyArray = [self.barView.childViews mutableCopy];
        for (NSInteger i = newCount - oldCount; i > 0; i--) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox-unchecked"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [copyArray addObject:imageView];
        }
        self.barView.childViews = copyArray;
    }else {
        NSMutableArray *copyArray = [self.barView.childViews mutableCopy];
        for (NSInteger i = oldCount - newCount; i > 0; i--) {
            [copyArray removeLastObject];
        }
        self.barView.childViews = copyArray;
    }
    
}

@end
