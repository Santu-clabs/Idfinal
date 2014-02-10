//
//  profileViewController.m
//  IDapp
//
//  Created by Click Labs on 2/8/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "profileViewController.h"
#import "Reachability.h"
#import "DataManager.h"



@interface profileViewController ()
{
     UIImageView *backGroundImageView;
   
}
@end

@implementation profileViewController

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
    topBarLabel.text = @"Profile";
    topBarLabel.textColor = [UIColor whiteColor];
    topBarLabel.font = [UIFont fontWithName:@"myriadwebpro-bold" size:18];
    topBarLabel.backgroundColor = [UIColor clearColor];
    topBarLabel.textAlignment = NSTextAlignmentCenter;
    [topBar addSubview:topBarLabel];
    
    //Menu button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backClick)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 45,45);
    [topBar addSubview:backButton];
    
     UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton  addTarget:self
                   action:@selector(editClick)
         forControlEvents:UIControlEventTouchUpInside];
    [editButton  setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateNormal];
    [editButton  setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateHighlighted];
    editButton .frame = CGRectMake(self.view.frame.size.width-50, 0, 45,45);
    [topBar addSubview:editButton];
    
    S =[[subview alloc] initWithFrame:CGRectMake(-80, 0, 80, self.view.frame.size.height)];
    S.vc=self;
    S.delegates=self;
    S.hidden=YES;
    [self.view addSubview:S];
    [self fetchdata];
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
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Unable to connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        NSString *atoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [[DataManager shared] activityIndicatorAnimate:@"Loading..." view:self.view];
        NSString *deviceType = [UIDevice currentDevice].model;
        dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
        dispatch_async(q_background, ^{
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&devicetype=%@&recipeid=0",atoken, deviceType];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@userprofileinfo", purl];
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
                NSLog(@"res%@",json);
                if ([[json objectForKey:@"error"] isEqualToString:@"Details of this user are not available"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[DataManager shared] removeActivityIndicator:self.view];
                                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Regestration failed" message:@"Please retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    });
                
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[DataManager shared] removeActivityIndicator:self.view];

                        UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 60, 55)];
                        NSArray *newDataArray = [[NSArray alloc] init];
                        newDataArray =[json objectForKey:@"data"];
                        
                        topBar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[0] objectForKey:@"image"]]]];
                        topBar.userInteractionEnabled = YES;
                        [backGroundImageView addSubview:topBar];
                        
                        //name
                        UILabel *lbltext = [[UILabel alloc] init];
                        lbltext.textColor = [UIColor blackColor];
                        lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                        lbltext.numberOfLines = 1;
                        lbltext.textAlignment = NSTextAlignmentJustified;
                        lbltext.text=[newDataArray[0] objectForKey:@"name"];
                        lbltext.backgroundColor=[UIColor clearColor];
                        lbltext.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                        lbltext.frame=CGRectMake(85, 55, 260, 25);
                        [lbltext setFont:[UIFont fontWithName:@"myriadwebpro-bold" size:17]];
                        lbltext.userInteractionEnabled=NO;
                        [backGroundImageView addSubview:lbltext];
                        {
                            //weight/age
                            UILabel *lbltext = [[UILabel alloc] init];
                            lbltext.textColor = [UIColor blackColor];
                            lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                            lbltext.numberOfLines = 1;
                            lbltext.textAlignment = NSTextAlignmentJustified;
                            NSString *nss=[NSString stringWithFormat:@"%@ years / %@ kg",[newDataArray[0] objectForKey:@"age"],[newDataArray[0] objectForKey:@"weight"]];
                            lbltext.text=nss;//[newDataArray[0] objectForKey:@"name"];
                            lbltext.backgroundColor=[UIColor clearColor];
                            lbltext.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                            lbltext.frame=CGRectMake(85, 74, 260, 25);
                            [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:14]];
                            lbltext.userInteractionEnabled=NO;
                            [backGroundImageView addSubview:lbltext];

                        }
                        //footer
                        {
                            UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, 75)];
                            NSArray *newDataArray = [[NSArray alloc] init];
                            newDataArray =[json objectForKey:@"data"];
                            topBar.image = [UIImage imageNamed:@"footer.jpg"];
                            topBar.userInteractionEnabled = YES;
                            [backGroundImageView addSubview:topBar];
                            
                            {
                            UILabel *lbltext = [[UILabel alloc] init];
                            lbltext.textColor = [UIColor blackColor];
                            lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                            lbltext.numberOfLines = 1;
                            lbltext.textAlignment =NSTextAlignmentCenter;
                            lbltext.text=@"Recipes";//[newDataArray[0] objectForKey:@"total_recipes"];
                            lbltext.backgroundColor=[UIColor clearColor];
                            lbltext.textColor=[UIColor whiteColor];
                            lbltext.frame=CGRectMake(0, 13, self.view.frame.size.width/2, 25);
                            [lbltext setFont:[UIFont fontWithName:@"myriadwebpro-bold" size:19]];
                            lbltext.userInteractionEnabled=NO;
                            [topBar addSubview:lbltext];
                            }
                            {
                                UILabel *lbltext = [[UILabel alloc] init];
                                lbltext.textColor = [UIColor blackColor];
                                lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                                lbltext.numberOfLines = 1;
                                lbltext.textAlignment =NSTextAlignmentCenter;
                                lbltext.text=@"Favorites";//[newDataArray[0] objectForKey:@"name"];
                                lbltext.backgroundColor=[UIColor clearColor];
                                lbltext.textColor=[UIColor whiteColor];
                                lbltext.frame=CGRectMake(self.view.frame.size.width/2, 13, self.view.frame.size.width/2, 25);
                                [lbltext setFont:[UIFont fontWithName:@"myriadwebpro-bold" size:19]];
                                lbltext.userInteractionEnabled=NO;
                                [topBar addSubview:lbltext];
                            }
                            {
                                UILabel *lbltext = [[UILabel alloc] init];
                                lbltext.textColor = [UIColor blackColor];
                                lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                                lbltext.numberOfLines = 1;
                                lbltext.textAlignment =NSTextAlignmentCenter;
                                lbltext.text=[newDataArray[0] objectForKey:@"total_recipes"];
                                lbltext.backgroundColor=[UIColor clearColor];
                                lbltext.textColor=[UIColor whiteColor];
                                lbltext.frame=CGRectMake(self.view.frame.size.width/2, 41, self.view.frame.size.width/2, 25);
                                [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Light" size:22]];
                                lbltext.userInteractionEnabled=NO;
                                [topBar addSubview:lbltext];
                            }
                            {
                                UILabel *lbltext = [[UILabel alloc] init];
                                lbltext.textColor = [UIColor blackColor];
                                lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                                lbltext.numberOfLines = 1;
                                lbltext.textAlignment =NSTextAlignmentCenter;
                                lbltext.text=[newDataArray[0] objectForKey:@"favorites"];
                                lbltext.backgroundColor=[UIColor clearColor];
                                lbltext.textColor=[UIColor whiteColor];
                                lbltext.frame=CGRectMake(0, 41, self.view.frame.size.width/2, 25);
                                [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Light" size:22]];
                                lbltext.userInteractionEnabled=NO;
                                [topBar addSubview:lbltext];
                            }

                            
                        }
                        {
                        UIImageView *mealBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 35)];
                        mealBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                        mealBar.userInteractionEnabled = YES;
                        [backGroundImageView addSubview:mealBar];
                        
                        
                            UILabel *lbltext = [[UILabel alloc] init];
                            lbltext.textColor = [UIColor blackColor];
                            lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                            lbltext.numberOfLines = 1;
                            lbltext.textAlignment =NSTextAlignmentCenter;
                            lbltext.text=@"Your Last Meal";//[newDataArray[0] objectForKey:@"name"];
                            lbltext.backgroundColor=[UIColor clearColor];
                            lbltext.textColor=[UIColor whiteColor];
                            lbltext.frame=CGRectMake(0, 5, self.view.frame.size.width, 25);
                            [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15]];
                            lbltext.userInteractionEnabled=NO;
                            [mealBar addSubview:lbltext];
                            
                            UIImageView *mealimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 225, self.view.frame.size.width, 135)];
                            mealimg.image = [UIImage imageNamed:@"meal.png"];
                            mealimg.userInteractionEnabled = YES;
                            [backGroundImageView addSubview:mealimg];
                            

                        }
                        {
                            //My health goal
                            UIImageView *mealBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 362, self.view.frame.size.width, 35)];
                            mealBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                            mealBar.userInteractionEnabled = YES;
                            [backGroundImageView addSubview:mealBar];
                            
                            
                            UILabel *lbltext = [[UILabel alloc] init];
                            lbltext.textColor = [UIColor blackColor];
                            lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                            lbltext.numberOfLines = 1;
                            lbltext.textAlignment =NSTextAlignmentCenter;
                            lbltext.text=@"My Health Goal";//[newDataArray[0] objectForKey:@"name"];
                            lbltext.backgroundColor=[UIColor clearColor];
                            lbltext.textColor=[UIColor whiteColor];
                            lbltext.frame=CGRectMake(0, 5, self.view.frame.size.width, 25);
                            [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15]];
                            lbltext.userInteractionEnabled=NO;
                            [mealBar addSubview:lbltext];
                            
                            UILabel *lblgoal = [[UILabel alloc] init];
                            lblgoal.textColor = [UIColor blackColor];
                            lblgoal.lineBreakMode = NSLineBreakByWordWrapping;
                            lblgoal.numberOfLines = 1;
                            lblgoal.textAlignment =NSTextAlignmentCenter;
                            lblgoal.text=[newDataArray[0] objectForKey:@"health_goals"];
                            lblgoal.backgroundColor=[UIColor clearColor];
                            lblgoal.textColor=[UIColor blackColor];
                            lblgoal.frame=CGRectMake(0, 397, self.view.frame.size.width, 25);
                            [lblgoal setFont:[UIFont fontWithName:@"MyriadPro-Light" size:10]];
                            lblgoal.userInteractionEnabled=NO;
                            [backGroundImageView addSubview:lblgoal];

                        }

                        {
                            //My health goal
                            UIImageView *mealBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 417, self.view.frame.size.width, 35)];
                            mealBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                            mealBar.userInteractionEnabled = YES;
                            [backGroundImageView addSubview:mealBar];
                            
                            
                            UILabel *lbltext = [[UILabel alloc] init];
                            lbltext.textColor = [UIColor blackColor];
                            lbltext.lineBreakMode = NSLineBreakByWordWrapping;
                            lbltext.numberOfLines = 1;
                            lbltext.textAlignment =NSTextAlignmentCenter;
                            lbltext.text=@"My Motivation";//[newDataArray[0] objectForKey:@"name"];
                            lbltext.backgroundColor=[UIColor clearColor];
                            lbltext.textColor=[UIColor whiteColor];
                            lbltext.frame=CGRectMake(0, 5, self.view.frame.size.width, 25);
                            [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15]];
                            lbltext.userInteractionEnabled=NO;
                            [mealBar addSubview:lbltext];
                            
                            UILabel *lblgoal = [[UILabel alloc] init];
                            lblgoal.textColor = [UIColor blackColor];
                            lblgoal.lineBreakMode = NSLineBreakByWordWrapping;
                            lblgoal.numberOfLines = 1;
                            lblgoal.textAlignment =NSTextAlignmentCenter;
                            lblgoal.text=[newDataArray[0] objectForKey:@"motivation"];
                            lblgoal.backgroundColor=[UIColor clearColor];
                            lblgoal.textColor=[UIColor blackColor];
                            lblgoal.frame=CGRectMake(0, 450, self.view.frame.size.width, 25);
                            [lblgoal setFont:[UIFont fontWithName:@"MyriadPro-Light" size:10]];
                            lblgoal.userInteractionEnabled=NO;
                            [backGroundImageView addSubview:lblgoal];
                            
                        }
                        {
                            UILabel *lblimgs = [[UILabel alloc] init];
                            lblimgs.textColor = [UIColor blackColor];
                            lblimgs.lineBreakMode = NSLineBreakByWordWrapping;
                            lblimgs.numberOfLines = 1;
                            lblimgs.textAlignment =NSTextAlignmentCenter;
                            lblimgs.text=@"American Pancakes";//[newDataArray[0] objectForKey:@"name"];
                            lblimgs.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
                            lblimgs.textColor=[UIColor whiteColor];
                            lblimgs.frame=CGRectMake(0, 335, self.view.frame.size.width, 25);
                            [lblimgs setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
                            lblimgs.userInteractionEnabled=NO;
                            [backGroundImageView addSubview:lblimgs];

                        }
                        
                    });
                    
                }
                
                
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *output = [error description];
                    NSLog(@"\n\n Error to get json=%@",output);
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Unable to connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                });
            }
        });
        
        
 
}
}
-(void)editClick{
   // EditProfileViewController *edvc=[[EditProfileViewController alloc]init];
    //[self redirect:edvc];
}
- (void)redirect:(UIViewController *)vc{
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
