//
//  AboutViewController.m
//  IDapp
//
//  Created by Click Labs on 2/7/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "AboutViewController.h"
#import "settingsViewController.h"

@interface AboutViewController ()
{
    UIImageView *backGroundImageView;
}
@end

@implementation AboutViewController

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
    topBarLabel.text = @"About";
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
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"about_logo_ipad.jpg"];
    [backGroundImageView addSubview:logoImageView];
    
    //
    UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signupButton addTarget:self
                     action:@selector(emailClick)
           forControlEvents:UIControlEventTouchUpInside];
    [signupButton setTitle:@"Rose@IdealWeightManagment.com" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signupButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:14];
    signupButton.backgroundColor=[UIColor clearColor];
    [signupButton setTitleColor:[UIColor colorWithRed:106/255.0f green:182/255.0f blue:109/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor colorWithRed:160.0/255 green:196.0/255 blue:111.0/255 alpha:1]  forState:UIControlStateHighlighted];
    
    
    [backGroundImageView addSubview:signupButton];
    
    
    
    UILabel *lbltext = [[UILabel alloc] init];
    lbltext.textColor = [UIColor blackColor];
    lbltext.lineBreakMode = NSLineBreakByWordWrapping;
    lbltext.numberOfLines = 3;
    lbltext.textAlignment = NSTextAlignmentCenter;
    lbltext.text=@"9127 SW 52nd Ave, Suite D103\nGainesVille, Florida 32608 \n 352.327.4120";
    lbltext.backgroundColor=[UIColor clearColor];
    lbltext.textColor=[UIColor blackColor];
    
    lbltext.textColor = [UIColor blackColor];
    [lbltext setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:16]];
    lbltext.userInteractionEnabled=NO;
    [backGroundImageView addSubview:lbltext];
    
    
    UIButton *webButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [webButton addTarget:self
                     action:@selector(webClick)
           forControlEvents:UIControlEventTouchUpInside];
    [webButton setTitle:@"WWW.IdealWeightManagement.com" forState:UIControlStateNormal];
    [webButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    webButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:14];
    webButton.backgroundColor=[UIColor clearColor];
    [webButton setTitleColor:[UIColor colorWithRed:106/255.0f green:182/255.0f blue:109/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [webButton setTitleColor:[UIColor colorWithRed:160.0/255 green:196.0/255 blue:111.0/255 alpha:1]  forState:UIControlStateHighlighted];
    
    
    [backGroundImageView addSubview:webButton];

    

	// Do any additional setup after loading the view.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            logoImageView.frame = CGRectMake(52, 84, 215, 215);
            
        
        } else
        {
            logoImageView.frame = CGRectMake(52, 60, 215, 165);
          signupButton.frame = CGRectMake(35, 225, 250, 41);
            webButton.frame=CGRectMake(35, 305, 250, 61);
            [lbltext setFrame:CGRectMake(35, 255, 250, 61)];
        }
    }
}
-(void)backClick{
    settingsViewController *svc=[[settingsViewController alloc]init];
    [self presentViewController:svc animated:YES completion:nil];
}
-(void)emailClick{
    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
    [composeViewController setMailComposeDelegate:self];
    [composeViewController setToRecipients:@[@"Rose@IdealWeightManagement.com"]];
    [composeViewController setSubject:@"Query? "];
    [self presentViewController:composeViewController animated:YES completion:nil];
}
-(void)webClick{
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://IdealWeightManagment.com"]];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
