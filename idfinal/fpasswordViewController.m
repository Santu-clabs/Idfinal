//
//  fpasswordViewController.m
//  IDapp
//
//  Created by Click Labs on 2/6/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "fpasswordViewController.h"
#import "Reachability.h"
#import "LoginViewController.h"

#define kOFFSET_FOR_KEYBOARD 120

@interface fpasswordViewController ()
{
    UITextField *uNametextField;
    UIView *m_view;
    UILabel *m_label;
    UIActivityIndicatorView *m_activity;
    UIActivityIndicatorView *spinner;
}
@end

@implementation fpasswordViewController

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
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
    //text
    UILabel *lbltextinfo = [[UILabel alloc] init];
    lbltextinfo.textColor = [UIColor blackColor];
    lbltextinfo.lineBreakMode = NSLineBreakByWordWrapping;
    lbltextinfo.numberOfLines = 3;
    lbltextinfo.textAlignment = NSTextAlignmentJustified;
    lbltextinfo.text=@"If you need help at any time during the purchase, please speak to our membership team on";
    lbltextinfo.backgroundColor=[UIColor clearColor];
    lbltextinfo.textColor=[UIColor blackColor];
    [lbltextinfo setFrame:CGRectMake(35, 200, 250, 70)];
    lbltextinfo.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    [lbltextinfo setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:15]];
    lbltextinfo.userInteractionEnabled=NO;
    [backGroundImageView addSubview:lbltextinfo];

    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"2_logo.png"];
    [backGroundImageView addSubview:logoImageView];
    
    //username
    UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 280, 250, 40)];
    nameBackGroundView.image = [UIImage imageNamed:@"2_username_inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [backGroundImageView addSubview:nameBackGroundView];
    
    uNametextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 287, 220, 30)];
    uNametextField.delegate=self;
    uNametextField.placeholder = @"Email";
    [uNametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    uNametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    uNametextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
    uNametextField.backgroundColor = [UIColor clearColor];
    [uNametextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    uNametextField.returnKeyType = UIReturnKeyNext;
    uNametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [backGroundImageView addSubview:uNametextField];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(loginClick)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Forget Password" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(35, 332, 250, 41);
    [backGroundImageView addSubview:loginButton];

    
    UILabel *lbltext = [[UILabel alloc] init];
    lbltext.textColor = [UIColor blackColor];
    lbltext.lineBreakMode = NSLineBreakByWordWrapping;
    lbltext.numberOfLines = 2;
    lbltext.textAlignment = NSTextAlignmentJustified;
    lbltext.text=@"Back to ";
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
    [signupButton setTitle:@"Login" forState:UIControlStateNormal];
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
            [lbltext setFrame:CGRectMake(120, 440, 250, 41)];
            
        }
    }

	// Do any additional setup after loading the view.
}

-(void)loginClick{
    
    if ([uNametextField.text length] == 0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self IsValidEmail:uNametextField.text Strict:YES])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid email field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        uNametextField.text=@"";
        
        
    }else{        Reachability *reach = [Reachability reachabilityForInternetConnection];
        
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
                NSString *post =[NSString stringWithFormat:@"email=%@",uNametextField.text];
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                NSString *urlString = [NSString stringWithFormat:@"%@forgotpassword", purl];
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
                    
                    if ([[json objectForKey:@"error"] isEqualToString:@"Mail not sent, please try again"] || [[json objectForKey:@"error"] isEqualToString:@"Invalid email id"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                             [[DataManager shared] removeActivityIndicator:self.view];
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forget password failed" message:@"please retry! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                        });
                       
                    }else if([[json objectForKey:@"log"] isEqualToString:@"Please check your mailbox to change password"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                             [[DataManager shared] removeActivityIndicator:self.view];
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forget password Success" message:@"Please check your mailbox to change password! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                        LoginViewController *vc=[[LoginViewController alloc]init];
                        [self presentViewController:vc animated:YES completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)signupClick{
    LoginViewController *lvc=[[LoginViewController alloc]init];
    [self presentViewController:lvc animated:YES completion:nil];
}
- (void)tapped

{
    
    [uNametextField resignFirstResponder];
   
    
    
    
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
-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [uNametextField becomeFirstResponder];

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
-(BOOL) IsValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}
- (void)activityIndicatorAnimate:(NSString *)textShown view:(UIView *)selfView
{
    
    selfView.userInteractionEnabled=NO;
    NSLog(@"animation start");
    
    m_view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    m_view.center = selfView.center ;
    
    [selfView addSubview:m_view];
    
    m_view.backgroundColor=[UIColor blackColor];
    
    m_view.alpha=0.7;
    
    m_view.layer.cornerRadius = 10;
    
    m_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 40)];
    
    m_label.font = [UIFont boldSystemFontOfSize:14];
    
    m_label.text=textShown;
    m_label.textAlignment = NSTextAlignmentCenter;
    m_label.textColor=[UIColor whiteColor];
    
    m_label.backgroundColor=[UIColor clearColor];
    
    [m_view addSubview:m_label];
    
    m_activity=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(33, 25,33, 33)];
    
    m_activity.color=[UIColor whiteColor];
    
    [m_view addSubview:m_activity];
    
    [m_activity startAnimating];
    
}

-(void)removeActivityIndicator :(UIView *)selfView

{
    NSLog(@"animation Stop");
    selfView.userInteractionEnabled=YES;
    
    [m_view removeFromSuperview];
    
    [m_label removeFromSuperview];
    
    [m_activity stopAnimating];
    
    [m_activity removeFromSuperview];
    
}

@end
