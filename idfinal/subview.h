//
//  subview.h
//  TechnoNews
//
//  Created by Click Labs on 1/29/14.
//  Copyright (c) 2014 Samar Singla. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol subviewDel <NSObject>
- (void)redirect:(UIViewController *)vc;

@end

@interface subview : UIView<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic, retain) UITableView *tvw;
@property (nonatomic,retain) UIViewController *vc;
@property (assign, nonatomic) id<subviewDel> delegates;

@end
