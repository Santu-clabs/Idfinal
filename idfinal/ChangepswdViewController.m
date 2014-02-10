//
//  ChangepswdViewController.m
//  IDapp
//
//  Created by Click Labs on 2/7/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "ChangepswdViewController.h"
#import "settingsViewController.h"
#import "Reachability.h"
#import "DataManager.h"
#define kOFFSET_FOR_KEYBOARD 30

@interface ChangepswdViewController (){
UIImageView *backGroundImageView;
    UITextField *uNametextField;
    UITextField *uPasswdtextField;
    UITextField *cPasswdtextField;
}

@end

@implementation ChangepswdViewController

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
    topBarLabel.text = @"Change Password";
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
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 45,45);
    [topBar addSubview:backButton];
    
    UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 100, 250, 40)];
    nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:nameBackGroundView];
    
    uNametextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 107, 220, 30)];
    uNametextField.delegate=self;
    uNametextField.placeholder = @"Old Password";
    [uNametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    uNametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    uNametextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
    uNametextField.backgroundColor = [UIColor clearColor];
    [uNametextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    uNametextField.returnKeyType = UIReturnKeyNext;
    uNametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    uNametextField.secureTextEntry=TRUE;
    [backGroundImageView addSubview:uNametextField];
    
    //Password
    UIImageView *passBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 150, 250, 40)];
    passBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    passBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:passBackGroundView];
    
    uPasswdtextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 157, 220, 30)];
    uPasswdtextField.delegate=self;
    uPasswdtextField.placeholder = @"New Password";
    [uPasswdtextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    uPasswdtextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    uPasswdtextField.borderStyle = UITextBorderStyleNone;uPasswdtextField.textAlignment = NSTextAlignmentLeft;
    uPasswdtextField.backgroundColor = [UIColor clearColor];
    [uPasswdtextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    uPasswdtextField.returnKeyType = UIReturnKeyNext;
    uPasswdtextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    uPasswdtextField.secureTextEntry=TRUE;
    [backGroundImageView addSubview:uPasswdtextField];
    
    UIImageView *cBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 200, 250, 40)];
    cBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    cBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:cBackGroundView];
    
    cPasswdtextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 207, 250, 30)];
    cPasswdtextField.delegate=self;
    cPasswdtextField.placeholder = @"Confirm Password";
    [cPasswdtextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    cPasswdtextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    cPasswdtextField.borderStyle = UITextBorderStyleNone;cPasswdtextField.textAlignment = NSTextAlignmentLeft;
    cPasswdtextField.backgroundColor = [UIColor clearColor];
    [cPasswdtextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    cPasswdtextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    cPasswdtextField.secureTextEntry=TRUE;
    [backGroundImageView addSubview:cPasswdtextField];
    
    //login
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(loginClick)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Change Password" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(35, 262, 250, 41);
    [backGroundImageView addSubview:loginButton];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [backGroundImageView addGestureRecognizer:tapScroll];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }

    
	// Do any additional setup after loading the view.
}
-(void)loginClick{
    
    if ([uNametextField.text length] == 0 || [uPasswdtextField.text length] == 0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if (![cPasswdtextField.text isEqualToString:uPasswdtextField.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"password not Match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        uPasswdtextField.text=@"";
        cPasswdtextField.text=@"";
        
        
    }else{
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
            dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
            dispatch_async(q_background, ^{
                NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&oldpassword=%@&newpassword=%@",atoken, uNametextField.text, cPasswdtextField.text];
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                NSString *urlString = [NSString stringWithFormat:@"%@resetpassword", purl];
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
                    if ([[json objectForKey:@"error"] isEqualToString:@"Unable to update password"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[DataManager shared] removeActivityIndicator:self.view];
                            uPasswdtextField.text=@"";
                            cPasswdtextField.text=@"";
                            uNametextField.text=@"";
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Regestration failed" message:@"Please retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                        });
                    }else if([[json objectForKey:@"error"] isEqualToString:@"Old password is wrong"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[DataManager shared] removeActivityIndicator:self.view];
                            uPasswdtextField.text=@"";
                            uNametextField.text=@"";
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Change Password Failed" message:@"Old password is wrong!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];});
                        
                    }else if([[json objectForKey:@"log"] isEqualToString:@"Password Updated Successfully"]){
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[DataManager shared] removeActivityIndicator:self.view];
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Change Password Success" message:@"Password Updated Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                          ;
                            
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
-(void)backClick{
    settingsViewController *svc=[[settingsViewController alloc]init];
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
    [cPasswdtextField resignFirstResponder];
    
    
    
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
