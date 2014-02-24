//
//  ProductlistViewController.m
//  idfinal
//
//  Created by Click Labs on 2/11/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "ProductlistViewController.h"
#import "Reachability.h"
#import "DataManager.h"
#include "productsViewController.h"

@interface ProductlistViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
}
@end

@implementation ProductlistViewController

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
    topBarLabel.text = @"Products";
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
    
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 560);
    [backGroundImageView addSubview:scrollview];
    
    //chnange password
    [self fetchdata];
    
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


	// Do any additional setup after loading the view.
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
-(void)fetchdata{
    
    
    //load others data
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Unable to connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        
        [[DataManager shared] activityIndicatorAnimate:@"Loading..." view:self.view];
        dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
        dispatch_async(q_background, ^{
             NSString *atoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@",atoken];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@getproductcategories", purl];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
            
            if (data)
            {
                

                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"json %@",json);
                NSArray *newDataArray = [[NSArray alloc] init];
                newDataArray =[json objectForKey:@"data"];
                for (int i=0; i<newDataArray.count; i++) {
                    
                    
                    
                    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [loginButton addTarget:self
                                    action:@selector(changePasswordClick:)
                          forControlEvents:UIControlEventTouchUpInside];
                    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
                    [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
                    loginButton.frame = CGRectMake(35, 45*i, 250, 31);
                    loginButton.tag=[[newDataArray[i] objectForKey:@"product_category_id"] integerValue];
                                       [scrollview addSubview:loginButton];
                    {
                        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(0, 4, 250, 20)];
                        alphatext.text=[newDataArray[i] objectForKey:@"product_category_name"];
                        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:16];
                        alphatext.backgroundColor=[UIColor clearColor];
                        alphatext.textColor=[UIColor whiteColor];
                        alphatext.textAlignment=NSTextAlignmentCenter;
                        [loginButton addSubview:alphatext];
                    }
                    
                }
                [[DataManager shared] removeActivityIndicator:self.view];
                
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *output = [error description];
                    NSLog(@"\n\n Error to get json=%@",output);
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Unable to connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [[DataManager shared] removeActivityIndicator:self.view];
                });
            }
        });
        
        
        
        
    }

    
    
}
- (void)redirect:(UIViewController *)vc{
     [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)changePasswordClick:(id)sender{
    productsViewController *pvc=[[productsViewController alloc]init];
    pvc.query=[NSString stringWithFormat:@"%ld",(long)[sender tag]];
    [self redirect:pvc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
