//
//  RecipeCatViewController.m
//  idfinal
//
//  Created by Click Labs on 2/14/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "RecipeCatViewController.h"
#import "Reachability.h"
#import "DataManager.h"
#import "RecipeViewController.h"
#import "RecipeListViewController.h"
@interface RecipeCatViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    UITextField *txtSearch;
    UILabel *topBarLabel;
    NSArray *newDataArray;
}
@end

@implementation RecipeCatViewController

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
    
    newDataArray= [[NSArray alloc] init];
    backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    backGroundImageView.image = [UIImage imageNamed:@"background_iphone_shared.png"];
    [self.view addSubview:backGroundImageView];
    
    UIImageView *topBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 00, 320, 45)];
    topBar.image = [UIImage imageNamed:@"header_img.png"];
    topBar.userInteractionEnabled = YES;
    [backGroundImageView addSubview:topBar];
    
    topBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    topBarLabel.text = _recipecategoryName;
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
    
    
    txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(85, 8, 150, 30)];
    txtSearch.delegate=self;
    txtSearch.placeholder = @"Password";
    [txtSearch setValue:[UIColor colorWithWhite:255 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    txtSearch.textColor = [UIColor colorWithWhite:255 alpha:0.8];
    txtSearch.borderStyle = UITextBorderStyleNone;txtSearch.textAlignment = NSTextAlignmentLeft;
    txtSearch.backgroundColor = [UIColor clearColor];
    [txtSearch setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:16]];
    txtSearch.returnKeyType = UIReturnKeyNext;
    txtSearch.autocapitalizationType = UITextAutocapitalizationTypeWords;
    txtSearch.hidden=YES;
    [topBar addSubview:txtSearch];
    
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton  addTarget:self
                    action:@selector(searchClick)
          forControlEvents:UIControlEventTouchUpInside];
    [editButton  setBackgroundImage:[UIImage imageNamed:@"search_btn.png"] forState:UIControlStateNormal];
    [editButton  setBackgroundImage:[UIImage imageNamed:@"search_btn.png"] forState:UIControlStateHighlighted];
    editButton .frame = CGRectMake(self.view.frame.size.width-50, 0, 45,45);
    [topBar addSubview:editButton];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-46)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 560);
    [backGroundImageView addSubview:scrollview];

    NSLog(@" Category found%@",_recipecategoryid);
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [scrollview addGestureRecognizer:tapScroll];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }
	// Do any additional setup after loading the view.
    [self fetchdata];
}
-(void)searchClick{
    if(txtSearch.hidden){
        [txtSearch becomeFirstResponder];
    txtSearch.hidden=NO;
        topBarLabel.hidden=YES;
    }else{
        [txtSearch resignFirstResponder];
    txtSearch.hidden=YES;
        topBarLabel.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&recipecategoryid=%@&devicetype=%@",atoken,_recipecategoryid,@"1"];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@getrecipesubcategorieslist", purl];
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
                    
                    int k=0;
                    newDataArray =[json objectForKey:@"data"];
                    
                    for(UIView *subview in [scrollview subviews]) {
                        
                        [subview removeFromSuperview];
                        
                    }
                    for (int i=0; i<newDataArray.count; i++) {
                        
                        
                            
                            UIButton *topBar = [[UIButton alloc] initWithFrame:CGRectMake(0, k, 320, 50)];
                            topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
                            
                            topBar.tag=[[newDataArray[i] objectForKey:@"sub_category_id"] integerValue];
                            [topBar addTarget:self action:@selector(categoryClick:) forControlEvents:UIControlEventTouchUpInside];
                            topBar.userInteractionEnabled = YES;
                            [scrollview addSubview:topBar];
                            
                            UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
                            divider.image=[UIImage imageNamed:@"divider.png"];
                            divider.userInteractionEnabled = YES;
                            [topBar addSubview:divider];
                            
                            UIImageView *umv=[[UIImageView alloc]initWithFrame:CGRectMake(topBar.frame.size.width-40, 4, 35, 35)];
                            umv.image=[UIImage imageNamed:@"list_arrow.png"];
                            [topBar addSubview:umv];
                            
                            //                        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 45, 45)];
                            //                        img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[i] objectForKey:@"image"]]]];
                            //                        [topBar addSubview:img];
                            //
                            {
                                UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(10, 6, 250, 25)];
                                alphatext.text=[newDataArray[i] objectForKey:@"name"];
                                alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                                alphatext.backgroundColor=[UIColor clearColor];
                                alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
                                alphatext.textAlignment=NSTextAlignmentLeft;
                                alphatext.tag=[[newDataArray[i] objectForKey:@"sub_category_id"] integerValue];
                                
                                [topBar addSubview:alphatext];
                            }
                        
                        k=k+45;
                        scrollview.contentSize=CGSizeMake(self.view.frame.size.width, k+60);
                        
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
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"fou %@",substring);
    
    [self showdata:substring];
    return YES;
}

-(void)showdata:(NSString *)query{
    int im=0;
    if([query isEqual:@""]){
        im=1;
        [txtSearch resignFirstResponder];
        txtSearch.hidden=YES;
        topBarLabel.hidden=NO;
    }
    
    for(UIView *subview in [scrollview subviews]) {
        
        [subview removeFromSuperview];
        
    }
    int k=0;
    for (int i=0; i<newDataArray.count; i++) {
        
        NSRange substringRange;
        if(im==1){
            substringRange=[@"1" rangeOfString:@"1"];
        }else{
            substringRange= [[[newDataArray[i] objectForKey:@"name"] lowercaseString] rangeOfString:[query lowercaseString]];
            
        }
                if (substringRange.location == 0) {

        //if([query isEqualToString:[newDataArray[i] objectForKey:@"name"]]){
        
        UIButton *topBar = [[UIButton alloc] initWithFrame:CGRectMake(0, k, 320, 50)];
        topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
        //topBar.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:16];
        topBar.tag=[[newDataArray[i] objectForKey:@"sub_category_id"] integerValue];
        [topBar addTarget:self action:@selector(categoryClick:) forControlEvents:UIControlEventTouchUpInside];
        topBar.userInteractionEnabled = YES;
          // [topBar setTitle:[newDataArray[i] objectForKey:@"name"] forState:UIControlStateNormal]; ;
        [scrollview addSubview:topBar];
        
        UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
        divider.image=[UIImage imageNamed:@"divider.png"];
        divider.userInteractionEnabled = YES;
        [topBar addSubview:divider];
        
        UIImageView *umv=[[UIImageView alloc]initWithFrame:CGRectMake(topBar.frame.size.width-40, 4, 35, 35)];
        umv.image=[UIImage imageNamed:@"list_arrow.png"];
        [topBar addSubview:umv];
        
        //                        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 45, 45)];
        //                        img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newDataArray[i] objectForKey:@"image"]]]];
        //                        [topBar addSubview:img];
        //
        {
            UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(10, 6, 250, 25)];
            alphatext.text=[newDataArray[i] objectForKey:@"name"];
            alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
            alphatext.backgroundColor=[UIColor clearColor];
            alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
            alphatext.textAlignment=NSTextAlignmentLeft;
            alphatext.tag=[[newDataArray[i] objectForKey:@"sub_category_id"] integerValue];
            
            //[topBar addSubview:alphatext];
        }
             k=k+45;
        }
        scrollview.contentSize=CGSizeMake(self.view.frame.size.width, k+60);

       
        
    }
    }
-(void)categoryClick:(id)Sender{
    for(int i=0;i<newDataArray.count;i++){
        if([[newDataArray[i] objectForKey:@"sub_category_id"] integerValue]==[Sender tag]){
            RecipeListViewController *rvc=[[RecipeListViewController alloc]init];
            rvc.recipecategoryid=[NSString stringWithFormat:@"%ld",(long)[Sender tag]];
            rvc.recipecategoryName=[newDataArray[i] objectForKey:@"name"];
             [self.navigationController pushViewController:rvc animated:YES];
            break;

        }
    }
    
}
-(void)tapped{
    [txtSearch resignFirstResponder];
}


@end
