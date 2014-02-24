//
//  GrocceryViewController.m
//  idfinal
//
//  Created by Click Labs on 2/21/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "GrocceryViewController.h"
#import "addGrocerryViewController.h"
#import "DataManager.h"
@interface GrocceryViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;

}
@end

@implementation GrocceryViewController

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
    backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
    UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 320, 45)];
    topBar.image = [UIImage imageNamed:@"header_img.png"];
    topBar.userInteractionEnabled = YES;
    [backGroundImageView addSubview:topBar];
    
    UILabel *topBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    topBarLabel.text = @"Groccery";
    topBarLabel.textColor = [UIColor whiteColor];
    topBarLabel.font = [UIFont fontWithName:@"myriadwebpro-bold" size:18];
    topBarLabel.backgroundColor = [UIColor clearColor];
    topBarLabel.textAlignment = NSTextAlignmentCenter;
    [topBar addSubview:topBarLabel];
    
    //back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backClick)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 45,45);
    [topBar addSubview:backButton];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-75)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 560);
    [backGroundImageView addSubview:scrollview];
    
    UIImageView *FooterBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-75, self.view.frame.size.width, 75)];

    FooterBar.image = [UIImage imageNamed:@"footer.jpg"];
        [backGroundImageView addSubview:FooterBar];
    
    UIButton *btnAdd= [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAdd addTarget:self
                  action:@selector(btnAddClick)
        forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    
    
    btnAdd.frame = CGRectMake(160, self.view.frame.size.height-75, 160, 75);
    [backGroundImageView addSubview:btnAdd];
    
    UIButton *btnClear= [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClear addTarget:self
               action:@selector(btnAddClick)
     forControlEvents:UIControlEventTouchUpInside];
    [btnClear setTitle:@"Clear" forState:UIControlStateNormal];
    [btnClear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnClear.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    
    
    btnClear.frame = CGRectMake(0, self.view.frame.size.height-75, 160, 75);
    [backGroundImageView addSubview:btnClear];

    
    S =[[subview alloc] initWithFrame:CGRectMake(-80, 0, 80, self.view.frame.size.height)];
    S.vc=self;
    S.delegates=self;
    S.hidden=YES;
    [self.view addSubview:S];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }
    [[DataManager shared]createDB];
    sqlite3_stmt *st=[[DataManager shared]fetchData:@"select distinct groceryTypeName from GroceryTable"];
    dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
    dispatch_async(q_background, ^{

        float k=0.0;
    while (sqlite3_step(st)==SQLITE_ROW) {
        char *offrName=(char *) sqlite3_column_text(st, 0);
        NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
        
         UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(0, k, self.view.frame.size.width, 50)];
        //vw.backgroundColor=[UIColor grayColor];
        UILabel *rowHeader=[[UILabel alloc]initWithFrame:CGRectMake(0, k, self.view.frame.size.width, 30)];
        rowHeader.text=offerString;
        rowHeader.textColor=[UIColor whiteColor];
        rowHeader.backgroundColor=[UIColor greenColor];
        [vw addSubview:rowHeader];
        
        
//        [[DataManager shared]createDB];
      sqlite3_stmt *sts=[[DataManager shared]fetchData:[NSString stringWithFormat:@"select * from GroceryTable where groceryTypeName='%@'",offerString]];
        while (sqlite3_step(sts)==SQLITE_ROW) {
        
        NSLog(@"data: %s  : %s  : %s  : %s  : %s",(char *) sqlite3_column_text(sts, 0),(char *) sqlite3_column_text(sts, 1),(char *) sqlite3_column_text(sts, 2),(char *) sqlite3_column_text(sts, 3),(char *) sqlite3_column_text(sts, 4));
        }
        [scrollview addSubview:vw];
        k=k+50;
        
    }
    });
    
	// Do any additional setup after loading the view.
}

-(void)btnAddClick{
    addGrocerryViewController *avc=[[addGrocerryViewController alloc]init];
    [self redirect:avc];
}

//-(void)btnAddGrocceryClick{
//    [[DataManager shared]createDB];
//    
//    if([[DataManager shared]insertData:[NSString stringWithFormat:@"insert into GroceryTable (groceryName,groceryTypeName) values ('%@','%@')",[NSString stringWithFormat:@"%@ %@",uiNoteQuantity.text,uiNoteName.text],uiNoteType.text]])
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully Added new Groccery" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick{
    if(S.hidden){
        S.hidden=NO;
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveLinear | UIViewAnimationOptionBeginFromCurrentState animations:^{
            S.frame=CGRectMake(0, 0, 80, self.view.frame.size.height);
            
            
            backGroundImageView.frame=CGRectMake(80.0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
                         completion:nil];
    }else{
        
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveLinear | UIViewAnimationOptionBeginFromCurrentState animations:^{
            S.frame=CGRectMake(-80, 0, 80, self.view.frame.size.height);
            
            
            backGroundImageView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        }
                         completion:^(BOOL finished)
         {
             S.hidden=YES;
         }];
        
        
    }
}
- (void)redirect:(UIViewController *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}


@end
