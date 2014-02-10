//
//  HomeViewController.m
//  IDapp
//
//  Created by Click Labs on 2/5/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "profileViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [super viewDidLoad];
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
   
 
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"2_logo.png"];
    [backGroundImageView addSubview:logoImageView];
    
    //collection view
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    collectionViews=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, 280) collectionViewLayout:layout];
    collectionViews.dataSource=self;
    collectionViews.delegate=self;
    
    [collectionViews registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViews setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:collectionViews];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            logoImageView.frame = CGRectMake(52, 84, 215, 215);
            
            
        } else
        {
            logoImageView.frame = CGRectMake(52, 10, 215, 150);
           
            
        }
    }

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return 9;
    
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    return 1;
    
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section

{
    
    return 1;
    
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    
    return 1;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    return CGSizeMake(106, 80);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIButton *cmn = [UIButton buttonWithType:UIButtonTypeCustom];
      cmn.frame = CGRectMake(18, 2, 66, 47);
    UILabel *lbltextinfo = [[UILabel alloc] init];
    lbltextinfo.backgroundColor=[UIColor clearColor];
    lbltextinfo.textColor=[UIColor blackColor];
    [lbltextinfo setFrame:CGRectMake(4, 47, cell.frame.size.width-8, 30)];
    lbltextinfo.textColor =[UIColor colorWithRed:60/255.0f green:132/255.0f blue:12/255.0f alpha:1.0f];
    [lbltextinfo setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12]];
    lbltextinfo.userInteractionEnabled=NO;
    lbltextinfo.textAlignment = NSTextAlignmentCenter;
   
    if(indexPath.row==0){
        [cmn addTarget:self action:@selector(myMenuPlannerClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_menuplanner.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_menuplanner_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.lineBreakMode = NSLineBreakByWordWrapping;
        lbltextinfo.numberOfLines = 2;
        
        lbltextinfo.text=@"MY MENU PLANNER";
          }
    if(indexPath.row==1){
        [cmn addTarget:self action:@selector(grocerryClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_grocery.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_grocery_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"GROCERY";
    }
    if(indexPath.row==2){
        [cmn addTarget:self action:@selector(recipesClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_recipes.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_recipes_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"RECIPES";
    }
    if(indexPath.row==3){
        [cmn addTarget:self action:@selector(favoritiesClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_favorite.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_favorite_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"FAVORITES";
    }
    if(indexPath.row==4){
        [cmn addTarget:self action:@selector(dailyClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_daily.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_daily_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"DAILY";
    }
    if(indexPath.row==5){
        [cmn addTarget:self action:@selector(myProgressClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_progress.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_progress_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"MY PROGRESS";
    }
    if(indexPath.row==6){
        [cmn addTarget:self action:@selector(productsClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_products.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_products_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"PRODUCTS";
    }
    if(indexPath.row==7){
        [cmn addTarget:self action:@selector(profileClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_profile.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_profile_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"PROFILE";
    }
    if(indexPath.row==8){
        [cmn addTarget:self action:@selector(settingsClick) forControlEvents:UIControlEventTouchUpInside];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_setting.png"] forState:UIControlStateNormal];
        [cmn setBackgroundImage:[UIImage imageNamed:@"5_setting_onclick.png"] forState:UIControlStateHighlighted];
        lbltextinfo.text=@"SETTINGS";
    }
   
    [cell addSubview:cmn];
    [cell addSubview:lbltextinfo];
    
    return cell;
}
-(void)myMenuPlannerClick{
    
}
-(void)settingsClick{
    settingsViewController *svc=[[settingsViewController alloc]init];
    [self presentViewController:svc animated:YES completion:nil];
}
-(void)dailyClick{
    
}
-(void)profileClick{
    profileViewController *pvc=[[profileViewController alloc]init];
    [self presentViewController:pvc animated:YES completion:nil];
}
-(void)productsClick{
    
}
-(void)myProgressClick{
    
}
-(void)recipesClick{
    
}
-(void)favoritiesClick{
    
}
-(void)grocerryClick{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
