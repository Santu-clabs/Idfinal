//
//  LoginViewController.m
//  IDapp
//
//  Created by Click Labs on 2/5/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "LoginViewController.h"

#define kOFFSET_FOR_KEYBOARD 80

@interface LoginViewController ()
{
}
@end

@implementation LoginViewController

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
    
    //background image
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"2_logo.png"];
    [backGroundImageView addSubview:logoImageView];
    
    //username
    UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 200, 250, 40)];
    nameBackGroundView.image = [UIImage imageNamed:@"2_username_inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:nameBackGroundView];
    
    uNametextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 207, 220, 30)];
    uNametextField.delegate=self;
    uNametextField.placeholder = @"User name";
    [uNametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    uNametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    uNametextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
    uNametextField.backgroundColor = [UIColor clearColor];
    [uNametextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    uNametextField.returnKeyType = UIReturnKeyNext;
    uNametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [backGroundImageView addSubview:uNametextField];
    
    //Password
    UIImageView *passBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 250, 250, 40)];
    passBackGroundView.image = [UIImage imageNamed:@"2_password_inputbox.png"];
    passBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:passBackGroundView];
    
    uPasswdtextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 257, 220, 30)];
    uPasswdtextField.delegate=self;
    uPasswdtextField.placeholder = @"Password";
    [uPasswdtextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    uPasswdtextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    uPasswdtextField.borderStyle = UITextBorderStyleNone;uPasswdtextField.textAlignment = NSTextAlignmentLeft;
    uPasswdtextField.backgroundColor = [UIColor clearColor];
    [uPasswdtextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    uPasswdtextField.returnKeyType = UIReturnKeyNext;
    uPasswdtextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    uPasswdtextField.secureTextEntry=TRUE;
    [backGroundImageView addSubview:uPasswdtextField];
    
    //login
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                   action:@selector(loginClick)
         forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(35, 302, 250, 41);
    [backGroundImageView addSubview:loginButton];
    
    {
        UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetButton addTarget:self
                       action:@selector(forgetClick)
             forControlEvents:UIControlEventTouchUpInside];
        [forgetButton setTitle:@"Forgot Password" forState:UIControlStateNormal];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        forgetButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:15];
        forgetButton.backgroundColor=[UIColor clearColor];
        [forgetButton setTitleColor:[UIColor colorWithRed:52/255.0f green:113/255.0f blue:105/255.0f alpha:1.0f]  forState:UIControlStateNormal];
        [forgetButton setTitleColor:[UIColor colorWithRed:160.0/255 green:196.0/255 blue:111.0/255 alpha:1]  forState:UIControlStateHighlighted];
        //[callButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
        //[callButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
        forgetButton.frame = CGRectMake(35, 342, 250, 41);
        [backGroundImageView addSubview:forgetButton];
    }
    //not a member
    
        UILabel *lbltext = [[UILabel alloc] init];
        lbltext.textColor = [UIColor blackColor];
        lbltext.lineBreakMode = NSLineBreakByWordWrapping;
        lbltext.numberOfLines = 2;
        lbltext.textAlignment = NSTextAlignmentJustified;
        lbltext.text=@"Not a member?";
        lbltext.backgroundColor=[UIColor clearColor];
        lbltext.textColor=[UIColor blackColor];
       
        lbltext.textColor = [UIColor blackColor];
        [lbltext setFont:[UIFont fontWithName:@"myriadwebpro-bold" size:17]];
        lbltext.userInteractionEnabled=NO;
        [backGroundImageView addSubview:lbltext];
    
    //signup
    UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signupButton addTarget:self
                     action:@selector(signupClick)
           forControlEvents:UIControlEventTouchUpInside];
    [signupButton setTitle:@"Signup" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signupButton.titleLabel.font = [UIFont fontWithName:@"myriadwebpro-bold" size:17];
    signupButton.backgroundColor=[UIColor clearColor];
    [signupButton setTitleColor:[UIColor colorWithRed:106/255.0f green:182/255.0f blue:109/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor colorWithRed:160.0/255 green:196.0/255 blue:111.0/255 alpha:1]  forState:UIControlStateHighlighted];
  
   
    [backGroundImageView addSubview:signupButton];

    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [backGroundImageView addGestureRecognizer:tapScroll];
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            logoImageView.frame = CGRectMake(52, 84, 215, 215);
             signupButton.frame = CGRectMake(35, 440, 150, 41);
             [lbltext setFrame:CGRectMake(35, 43, 250, 70)];
            
        } else
        {
            logoImageView.frame = CGRectMake(52, 10, 215, 165);
             signupButton.frame = CGRectMake(155, 440, 100, 41);
             [lbltext setFrame:CGRectMake(55, 440, 250, 41)];

        }
    }

}
-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [uNametextField becomeFirstResponder];
            [uPasswdtextField becomeFirstResponder];
        } else
        {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow)
                                                         name:UIKeyboardWillShowNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide)                                                       name:UIKeyboardWillHideNotification
                                                       object:nil];
            
        }
    }
    
}
-(void)loginClick{
    
    if ([uNametextField.text length] == 0 || [uPasswdtextField.text length] == 0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
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
            NSString *post =[NSString stringWithFormat:@"email=%@&password=%@&version=%@",uNametextField.text, uPasswdtextField.text, versions];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@userlogin", purl];
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
                NSLog(@"json %@",json);
                 NSLog(@"response: %@",[json objectForKey:@"access_token"]);
                if ([[json objectForKey:@"error"] isEqualToString:@"Incorrect Password"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [[DataManager shared] removeActivityIndicator:self.view];
                    uPasswdtextField.text=@"";
                    uNametextField.text=@"";
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login failed" message:@"Username or password wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    });
                    
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[NSUserDefaults standardUserDefaults] setObject:@"exampletoken" forKey:@"token"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    HomeViewController *svc = [[HomeViewController  alloc] init];
//                    [self presentViewController:svc animated:YES completion:nil];
//                    
//                });
                }else if([[json objectForKey:@"log"] isEqualToString:@"New user"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [[DataManager shared] removeActivityIndicator:self.view];
                    uPasswdtextField.text=@"";
                    uNametextField.text=@"";
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login failed" message:@"Don't have any account corrosponding the user name. Please sign up! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];});
                
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [[DataManager shared] removeActivityIndicator:self.view];
                        NSArray *newDataArray = [[NSArray alloc] init];
                        newDataArray =[json objectForKey:@"data"];
                    
                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                            NSString *dbDestinationPath = [[documentsDirectory stringByAppendingString:@"/"] stringByAppendingString:@"IdealAppetitie.db"];
                                NSError *error;
                               NSData *nsd=[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[0] objectForKey:@"db_file"]]];
                                
                                [nsd writeToFile:dbDestinationPath options:NSDataWritingAtomic error:nil];

                            [[NSUserDefaults standardUserDefaults] setObject:[newDataArray[0] objectForKey:@"access_token"] forKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] setObject:[newDataArray[0] objectForKey:@"db_file"] forKey:@"db_file"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            HomeViewController *svc = [[HomeViewController  alloc] init];
                            [self presentViewController:svc animated:YES completion:nil];

                        });
                        
                        
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
    
    
}
-(void)forgetClick{
    fpasswordViewController *fvc=[[fpasswordViewController alloc]init];
    [self presentViewController:fvc animated:YES completion:nil];

}
-(void)signupClick{
    NAcntViewController *svc = [[NAcntViewController  alloc] init];
    [self presentViewController:svc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapped

{
    
    [uNametextField resignFirstResponder];
    [uPasswdtextField resignFirstResponder];
    
    
    
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


-(void)keyboardWillHide {if (self.view.frame.origin.y >= 0)
{
    [self setViewMovedUp:YES];
}
else if (self.view.frame.origin.y < 0)
{
    [self setViewMovedUp:NO];
}
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    CGRect rect = self.view.frame;if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        // rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

@end
