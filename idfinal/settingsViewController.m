//
//  settingsViewController.m
//  IDapp
//
//  Created by Click Labs on 2/6/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "settingsViewController.h"
#import "LoginViewController.h"
#import "ChangepswdViewController.h"
#import "AboutViewController.h"


@interface settingsViewController ()
{
    UIImageView *backGroundImageView;
}
@end

@implementation settingsViewController

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
    topBarLabel.text = @"Settings";
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
    
    //chnange password
    {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton addTarget:self
                        action:@selector(changePasswordClick)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"Change password" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake(35, 100, 250, 41);
        [backGroundImageView addSubview:loginButton];
    }
    
    //About
    {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton addTarget:self
                        action:@selector(aboutClick)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"About" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake(35, 154, 250, 41);
        [backGroundImageView addSubview:loginButton];
    }
    //Payment info
    {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton addTarget:self
                        action:@selector(paymentInfoClick)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"Payment info" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake(35, 208, 250, 41);
        [backGroundImageView addSubview:loginButton];
    }
    //Synchronize
    {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton addTarget:self
                        action:@selector(synchronizeClick)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"Synchronize" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake(35, 262, 250, 41);
        [backGroundImageView addSubview:loginButton];
    }
    //logout
    {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton addTarget:self
                        action:@selector(logoutClick)
              forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake(35, 316, 250, 41);
        [backGroundImageView addSubview:loginButton];
    }
    
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
-(void)changePasswordClick{
    ChangepswdViewController *CVc=[[ChangepswdViewController alloc]init];
   
    [self.navigationController pushViewController:CVc animated:YES];
    
   
}
-(void)paymentInfoClick{
    
}
-(void)synchronizeClick{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Unable to connect to server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fileName = @"IdealAppetitie.db";
        NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        NSData *nsds=[NSData dataWithContentsOfFile:folderPath];

        
          NSString *atoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [[DataManager shared] activityIndicatorAnimate:@"Sync..." view:self.view];
        dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
        dispatch_async(q_background, ^{

            NSString *urlString = [NSString stringWithFormat:@"%@uploadfile", purl];
            NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
            
            NSString *PathToFile = [stringPath stringByAppendingPathComponent:[NSString stringWithFormat:@"IdealAppetite.db"]];

          
            NSData* fileData = [[NSData alloc] initWithContentsOfFile:folderPath] ;
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"0xKhTmLbOuNdArY"; // This is important! //NSURLConnection is very sensitive to format.
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"dbfile\"; filename=\"IdealAppetite.db\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:fileData]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"useraccesstoken\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[atoken dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
           
            
            [request setHTTPBody:body];
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            
            //NSData *data = [NSURLConnection sendSynchronousRequest:request
             //                                    returningResponse:&response
              //                                               error:&error];
           NSError *error = nil;
            if (data)
            {
                [[DataManager shared] removeActivityIndicator:self.view];
                dispatch_async(dispatch_get_main_queue(), ^{

                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"json %@",json);
                if ([[json objectForKey:@"error"] isEqualToString:@"Unable to upload db file"] || [[json objectForKey:@"error"] isEqualToString:@"Invalid file is uploaded"] || [[json objectForKey:@"error"] isEqualToString:@"File is not uploaded"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                    
                        [[DataManager shared] removeActivityIndicator:self.view];
                                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Synchronization failed" message:@"Please retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                   
                }else if([[json objectForKey:@"log"] isEqualToString:@"Dbfile uploaded successfully"]){
                    
                                            [[DataManager shared] removeActivityIndicator:self.view];
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Synchronize Success" message:@"Synchronize success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                        ;
                        
                    
                }
                               });

            
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
-(void)aboutClick{
    
    AboutViewController *CVc=[[AboutViewController alloc]init];

    [self.navigationController pushViewController:CVc animated:YES];
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
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    // here I put the code to set the posting button off the top of the view
    [UIView commitAnimations];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)logoutClick{
    [self synchronizeClick];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"IdealAppetitie.db"];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Congratulation:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [removeSuccessFulAlert show];
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
    if (error){
        NSLog(@"%@", error);
    }
    LoginViewController *ovc = [[LoginViewController alloc] init];
     [self.navigationController pushViewController:ovc animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
