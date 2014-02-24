//
//  EditViewController.m
//  idfinal
//
//  Created by Click Labs on 2/10/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "EditViewController.h"
#import "profileViewController.h"
#define kOFFSET_FOR_KEYBOARD 100
#import "DataManager.h"
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface EditViewController ()
{
    UIImageView *backGroundImageView;
    UITextField *uNametextField;
    UITextField *unametextField;
    UITextField *uagetextField;
    UITextField *usextextField;
    UITextView *tvmhg;
    UITextView *tvmm;
    UIImageView *Cphoto;
    UIScrollView *scrollview ;
    UIView *uiviewPopup;
    UIImage *pickimg;
    NSURL *localUrl ;
    NSString *fileNames ;
    UIImage *chosenImage;

}
@end

@implementation EditViewController

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
    backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    NSString *sourceDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *destinationDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:sourceDirectory error:&error];
    
    for(NSString *sourceFileName in contents) {
        NSLog(@"%@",sourceFileName);
//        NSString *sourceFile = [sourceDirectory stringByAppendingPathComponent:sourceFileName];
//        NSString *destFile = [destinationDirectory stringByAppendingPathComponent:sourceFileName];
//        if(![fileManager moveItemAtPath:sourceFile toPath:destFile error:&error]) {
//            NSLog(@"Error: %@", error);
//        }
    }
    
   
    
    UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 320, 45)];
    topBar.image = [UIImage imageNamed:@"header_img.png"];
    topBar.userInteractionEnabled = YES;
    [backGroundImageView addSubview:topBar];
    
    UILabel *topBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    topBarLabel.text = @"Edit Profile";
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
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 195, self.view.frame.size.width, 225)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 350);
    [backGroundImageView addSubview:scrollview];
       [self fetchdata];

    
    pickimg=[[UIImage alloc]init];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(saveClick)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Save" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(35, self.view.frame.size.height-46, 250, 41);
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

}
	// Do any additional setup after loading the view.
    -(void)saveClick{
        
Cphoto.image=Nil;
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
            NSString *fileName = @"groupImage.jpeg";
            NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            NSData *nsds=[NSData dataWithContentsOfFile:folderPath];

            
            NSString *atoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            [[DataManager shared] activityIndicatorAnimate:@"Loading..." view:self.view];
            
            dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
            dispatch_async(q_background, ^{
                NSString *urlString = [NSString stringWithFormat:@"%@updateuserprofile", purl];
                NSData *fileData = nsds;
                
                Cphoto.image=[UIImage imageWithData:fileData];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString]];
                [request setHTTPMethod:@"POST"];
                
                NSString *boundary = @"0xKhTmLbOuNdArY"; // This is important! //NSURLConnection is very sensitive to format.
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                
                NSMutableData *body = [NSMutableData data];
                //useraccesstoken
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"useraccesstoken\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[atoken dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //name
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"name\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[uNametextField.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //username
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"username\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[unametextField.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //age
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"age\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[uagetextField.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //weight
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"weight\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[usextextField.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //healthgoal
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"healthgoals\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[tvmhg.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //motivation
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"motivation\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[tvmm.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
              
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                NSString *names=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"groupImage.jpeg\"\r\n"];
                [body appendData:[names dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:fileData]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [request setHTTPBody:body];
               
                
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                
                
                
                NSError *error = nil;

                [request setHTTPBody:body];
                if (data)
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[DataManager shared] removeActivityIndicator:self.view];
                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                        NSLog(@"json %@",json);
                        
                        
                        if ([[json objectForKey:@"error"] isEqualToString:@"Unable to update user profile"] || [[json objectForKey:@"error"] isEqualToString:@"User Image is not uploaded"] || [[json objectForKey:@"error"] isEqualToString:@"Unable to upload user image"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[DataManager shared] removeActivityIndicator:self.view];
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Upload error" message:@"Please Retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [alert show];
                            });
                        }else if ([[json objectForKey:@"log"] isEqualToString:@"User profile updated successfully"]){
                            [[DataManager shared] removeActivityIndicator:self.view];
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Profile Update success" message:@"User profile updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];

                        }else if ([[json objectForKey:@"log"] isEqualToString:@"Username already exists"]){
                            [[DataManager shared] removeActivityIndicator:self.view];
                            unametextField.text=@"";
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Profile Update success" message:@"Username already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                            
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
                        
                        NSArray *newDataArray = [[NSArray alloc] init];
                        newDataArray =[json objectForKey:@"data"];

                        Cphoto = [[UIImageView alloc] initWithFrame:CGRectMake(85, 55, 150, 125)];
                        Cphoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[0] objectForKey:@"image"]]]];
                        Cphoto.userInteractionEnabled = YES;
                        [backGroundImageView addSubview:Cphoto];
                        pickimg=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[0] objectForKey:@"image"]]]];
                        
                        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [loginButton addTarget:self
                                        action:@selector(editProfilePhotoClick)
                              forControlEvents:UIControlEventTouchUpInside];
                        [loginButton setTitle:@"Choose Photo" forState:UIControlStateNormal];
                        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15];
                        
                        loginButton.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
                        [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateNormal];
                        [loginButton setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
                        loginButton.frame = CGRectMake(25, 52, 100, 21);
                        [Cphoto addSubview:loginButton];

                        
                        
                        //name
                        
                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 5, 250, 40)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                                }
                        uNametextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 12, 220, 30)];
                        uNametextField.delegate=self;
                        uNametextField.placeholder = @"Name";
                        [uNametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        uNametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        uNametextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
                        uNametextField.backgroundColor = [UIColor clearColor];
                        [uNametextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        uNametextField.returnKeyType = UIReturnKeyNext;
                        uNametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        uNametextField.text=[newDataArray[0] objectForKey:@"name"];
                        [scrollview addSubview:uNametextField];


                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 55, 250, 40)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                        }
                        unametextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 62, 220, 30)];
                        unametextField.delegate=self;
                        unametextField.placeholder = @"User Name";
                        [unametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        unametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        unametextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
                        unametextField.backgroundColor = [UIColor clearColor];
                        [unametextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        unametextField.returnKeyType = UIReturnKeyNext;
                        unametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        unametextField.text=[newDataArray[0] objectForKey:@"username"];
                        [scrollview addSubview:unametextField];
                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 105, 250, 40)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                        }
                        uagetextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 112, 220, 30)];
                        uagetextField.delegate=self;
                        uagetextField.placeholder = @"Age";
                        [uagetextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        uagetextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        uagetextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
                        uagetextField.backgroundColor = [UIColor clearColor];
                        [uagetextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        uagetextField.returnKeyType = UIReturnKeyNext;
                        uagetextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        uagetextField.text=[newDataArray[0] objectForKey:@"age"];
                        [scrollview addSubview:uagetextField];

                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 155, 250, 40)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                        }
                        usextextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 162, 220, 30)];
                        usextextField.delegate=self;
                        usextextField.placeholder = @"Weight";
                        [usextextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        usextextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        usextextField.borderStyle = UITextBorderStyleNone;uNametextField.textAlignment = NSTextAlignmentLeft;
                        usextextField.backgroundColor = [UIColor clearColor];
                        [usextextField setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        usextextField.returnKeyType = UIReturnKeyNext;
                        usextextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        usextextField.text=[newDataArray[0] objectForKey:@"weight"];
                        [scrollview addSubview:usextextField];

                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 210, 250, 60)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                        }
                        tvmhg = [[UITextView alloc] initWithFrame:CGRectMake(45, 217, 220, 60)];
                        tvmhg.delegate=self;
                       
                        tvmhg.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        
                        tvmhg.backgroundColor = [UIColor clearColor];
                        [tvmhg setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        tvmhg.returnKeyType = UIReturnKeyNext;
                        tvmhg.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        tvmhg.text=[newDataArray[0] objectForKey:@"health_goals"];
                        
                        [scrollview addSubview:tvmhg];

                        
                        
                        
                        
                        {
                            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 280, 250, 60)];
                            nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
                            nameBackGroundView.userInteractionEnabled = YES;
                            [scrollview addSubview:nameBackGroundView];
                            
                        }
                        tvmm = [[UITextView alloc] initWithFrame:CGRectMake(45, 287, 220, 60)];
                        tvmm.delegate=self;
                        
                        tvmm.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
                        
                        tvmm.backgroundColor = [UIColor clearColor];
                        [tvmm setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        tvmm.returnKeyType = UIReturnKeyNext;
                        tvmm.autocapitalizationType = UITextAutocapitalizationTypeWords;
                        tvmm.text=[newDataArray[0] objectForKey:@"motivation"];
                        [scrollview addSubview:tvmm];
                        
                        
                        
                        
                        //popup
                        uiviewPopup=[[UIView alloc]init ];
                        
                        
                        uiviewPopup.frame=CGRectMake(10, (self.view.frame.size.height-130)/2, 300, 130);
                        
                        UIGraphicsBeginImageContext(self.view.frame.size);
                        [[UIImage imageNamed:@"popup_box.png"] drawInRect:uiviewPopup.bounds];
                        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        uiviewPopup.backgroundColor=[UIColor colorWithPatternImage:image];
                        uiviewPopup.hidden=YES;
                        [backGroundImageView addSubview:uiviewPopup];
                        
                        UIButton *btnClosePopupView = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnClosePopupView addTarget:self
                                              action:@selector(btnClosePopupViewClick)
                                    forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateNormal];
                        [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateHighlighted];
                        btnClosePopupView.frame = CGRectMake(270, 10, 20, 20);
                        [uiviewPopup addSubview:btnClosePopupView];
                        
                        UIButton *btnChooseFromGalleryPopupView = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnChooseFromGalleryPopupView addTarget:self
                                              action:@selector(btnChooseFromGalleryPopupViewClick)
                                    forControlEvents:UIControlEventTouchUpInside];
                        [btnChooseFromGalleryPopupView setTitle:@"Choose from Gallery" forState:UIControlStateNormal];
                        [btnChooseFromGalleryPopupView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        btnChooseFromGalleryPopupView.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15];

                        
                        [btnChooseFromGalleryPopupView setBackgroundImage:[UIImage imageNamed:@"recipes_btn.png"] forState:UIControlStateNormal];
                        [btnChooseFromGalleryPopupView setBackgroundImage:[UIImage imageNamed:@"recipes_btn_onclick.png"] forState:UIControlStateHighlighted];
                        btnChooseFromGalleryPopupView.frame = CGRectMake(40, 30, 200, 30);
                        [uiviewPopup addSubview:btnChooseFromGalleryPopupView];

                        UIButton *btnChooseFromCameraPopupView = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnChooseFromCameraPopupView addTarget:self
                                              action:@selector(btnChooseFromCameraPopupViewClick)
                                    forControlEvents:UIControlEventTouchUpInside];
                        [btnChooseFromCameraPopupView setTitle:@"Choose from Camera" forState:UIControlStateNormal];
                        [btnChooseFromCameraPopupView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        btnChooseFromCameraPopupView.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15];

                        
                        [btnChooseFromCameraPopupView setBackgroundImage:[UIImage imageNamed:@"recipes_btn.png"] forState:UIControlStateNormal];
                        [btnChooseFromCameraPopupView setBackgroundImage:[UIImage imageNamed:@"recipes_btn_onclick.png"] forState:UIControlStateHighlighted];
                        btnChooseFromCameraPopupView.frame = CGRectMake(40, 70, 200, 30);
                        [uiviewPopup addSubview:btnChooseFromCameraPopupView];

                        //end popup

                        
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
-(void)btnChooseFromGalleryPopupViewClick{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)btnChooseFromCameraPopupViewClick{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }else{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    
    [self presentViewController:picker animated:YES completion:NULL];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/FullImages"];
    NSString *fileName = @"groupImage.jpeg";
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *nsds=[NSData dataWithContentsOfFile:folderPath];
    }
    
    
    UIImage *uploadImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    float hfactor = uploadImage.size.width / self.view.bounds.size.width;
    
    float vfactor = uploadImage.size.height / self.view.bounds.size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    
    float newWidth = uploadImage.size.width / factor;
    
    float newHeight = uploadImage.size.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    
    // float leftOffset = (screenBounds.size.width - newWidth) / 2;
    
    //float topOffset = (screenBounds.size.height - newHeight) / 2;
    
    // CGRect newRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
    
    // Create a graphics image context
    
    NSLog(@"%f,%f",2*newWidth,2*newHeight);
    
    CGSize newSize = CGSizeMake(2*newWidth, 2*newHeight);
    
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [uploadImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    
    UIGraphicsEndImageContext();
    
    
    
    //groupPhotoPicker.delegate=nil;
    
    picker.delegate=nil;
    
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    //[groupPhotoPicker dismissViewControllerAnimated:NO completion:nil];
    
    NSString *savedGroupImagePath=[[NSString alloc]init];
    NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
      NSString *documentDirectory = [paths objectAtIndex:0];
    
    savedGroupImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"groupImage.jpeg"]];
    
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    [imageData writeToFile:savedGroupImagePath atomically:YES];
    
    
    
    //[self startCustomLoader];
    
    // [self serverCallSync];
    
    
    
    //[self performSelectorOnMainThread:@selector(showPreviewScreen) withObject:nil waitUntilDone:YES];
    
    uploadImage=nil;
    
    //[self showPreviewScreen];
    
//    chosenImage = info[UIImagePickerControllerEditedImage];
//    chosenImage=(UIImage*)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    Cphoto.image = chosenImage;
//    pickimg=chosenImage;
//    localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
//    
//    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
//    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
//    {
//        ALAssetRepresentation *representation = [myasset defaultRepresentation];
//        fileNames = [representation filename];
//        NSLog(@"fileName : %@",fileNames);
//  
//        
//        
//    };
//    
//    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
//    [assetslibrary assetForURL:imageURL
//                   resultBlock:resultblock
//                  failureBlock:nil];
    
    
    
  
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [uNametextField resignFirstResponder];
            [unametextField resignFirstResponder];
            [uagetextField resignFirstResponder];
            [usextextField resignFirstResponder];
            [tvmhg resignFirstResponder];
            [tvmm resignFirstResponder];
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
-(void)editProfilePhotoClick{
    uiviewPopup.hidden=NO;
    

   
    
}
-(void)btnClosePopupViewClick{
    uiviewPopup.hidden=YES;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapped

{
    
    [uNametextField resignFirstResponder];
    [unametextField resignFirstResponder];
    [uagetextField resignFirstResponder];
    [usextextField resignFirstResponder];
    [tvmhg resignFirstResponder];
    [tvmm resignFirstResponder];
    
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
