//
//  subview.m
//  TechnoNews
//
//  Created by Santu D. on 1/29/14.
//  Copyright (c) 2014 Samar Singla. All rights reserved.
//

#import "subview.h"

#include "HomeViewController.h"
#include "settingsViewController.h"
#import "profileViewController.h"


@implementation subview
{

   
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor colorWithRed:26/255.0f green:26/255.0f blue:26/255.0f alpha:1.0f];
        
        _tvw=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        _tvw.delegate=self;
        _tvw.backgroundColor=[UIColor colorWithRed:26/255.0f green:26/255.0f blue:26/255.0f alpha:1.0f];
        _tvw.dataSource=self;
       [_tvw setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self addSubview:_tvw];
        
        UIImage *image = [UIImage imageNamed:@"40_navigation_shadow.png"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(63, 0, 17, self.frame.size.height)];
        
        [iv setImage:image];
        
        
        [self addSubview:iv];
//            [self.layer setShadowColor:[UIColor blackColor].CGColor];
//            [self.layer setShadowOpacity:0.9];
//            [self.layer setShadowOffset:CGSizeMake(1,0)];
        
    }
    NSLog(@"Bottom View Loaded");
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 9;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    UIButton *cmn = [UIButton buttonWithType:UIButtonTypeCustom];
    cmn.frame = CGRectMake(1, 1, 80, 72);
    UILabel *lbltextinfo = [[UILabel alloc] init];
    lbltextinfo.backgroundColor=[UIColor clearColor];
    
    [lbltextinfo setFrame:CGRectMake(0, 45, 85, 30)];
    lbltextinfo.textColor =[UIColor whiteColor];
    [lbltextinfo setFont:[UIFont fontWithName:@"myriadwebpro-bold" size:8.9]];
    lbltextinfo.userInteractionEnabled=NO;
    lbltextinfo.textAlignment = NSTextAlignmentCenter;
    lbltextinfo.text=@"HI";
    [cell addSubview:lbltextinfo];
    
    if(indexPath.row==0){
        [cmn addTarget:self action:@selector(homeClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_home_ipad.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_home_ipad.png"] forState:UIControlStateHighlighted];
        lbltextinfo.lineBreakMode = NSLineBreakByWordWrapping;
        lbltextinfo.numberOfLines = 2;
        
        lbltextinfo.text=@"HOME";
    }
    if(indexPath.row==1){
        [cmn addTarget:self action:@selector(grocerryClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_grocery.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_grocery.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"GROCERY";
    }
    if(indexPath.row==2){
        [cmn addTarget:self action:@selector(recipesClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_recipes.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_recipes.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"RECIPES";
    }
    if(indexPath.row==3){
        [cmn addTarget:self action:@selector(favoritiesClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_products.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_products.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"PRODUCTS";
    }
    if(indexPath.row==4){
        [cmn addTarget:self action:@selector(dailyClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_favorite.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_favorite.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"FAVORITIES";
    }
    if(indexPath.row==5){
        [cmn addTarget:self action:@selector(myProgressClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_progress.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_progress.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"MY PROGRESS";
    }
    if(indexPath.row==7){
        [cmn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_profile.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_profile.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"PROFILE";
    }
    if(indexPath.row==6){
        [cmn addTarget:self action:@selector(dailyClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_daily_ipad.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_daily_ipad.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"DAILY";
    }
    if(indexPath.row==8){
        [cmn addTarget:self action:@selector(settingsClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_setting.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"40_setting.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"SETTINGS";
    }
    
    [cell addSubview:cmn];
    
    UIImage *image = [UIImage imageNamed:@"40_divider.png"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 1)];
    
        [iv setImage:image];
    
    
    [cell.contentView addSubview:iv];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
    
   
}
-(void)homeClick{
      HomeViewController *hvc=[[HomeViewController alloc]init];
     [self.delegates redirect:hvc];
    
}
-(void)settingsClick{
    
    settingsViewController *hvc=[[settingsViewController alloc]init];
    [self.delegates redirect:hvc];
    
}
-(void)profileClick{
    profileViewController *pvc=[[profileViewController alloc]init];
    [self.delegates redirect:pvc];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
