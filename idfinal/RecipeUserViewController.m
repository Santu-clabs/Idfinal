//
//  RecipeUserViewController.m
//  idfinal
//
//  Created by Click Labs on 2/18/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "RecipeUserViewController.h"
#import "DataManager.h"
#import "AsyncImageView.h"
#import "Reachability.h"
#import "RecipeDetailsViewController.h"

@interface RecipeUserViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    UIButton *BtnRecipe;
    UIButton *BtnProducts;
    
}
@end

@implementation RecipeUserViewController

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
    topBarLabel.text = @"User Recipe";
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
    
    BtnRecipe= [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnRecipe addTarget:self
                  action:@selector(BtnRecipeClick)
        forControlEvents:UIControlEventTouchUpInside];
    [BtnRecipe setTitle:@"Shared Recipes" forState:UIControlStateNormal];
    [BtnRecipe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BtnRecipe.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [BtnRecipe setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateNormal];
    [BtnRecipe setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    BtnRecipe.frame = CGRectMake(-4, 45, 165, 45);
    [backGroundImageView addSubview:BtnRecipe];
    
    BtnProducts= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [BtnProducts addTarget:self
                    action:@selector(BtnProductsClick)
          forControlEvents:UIControlEventTouchUpInside];
    [BtnProducts setTitle:@"My Recipes" forState:UIControlStateNormal];
    [BtnProducts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BtnProducts.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [BtnProducts setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [BtnProducts setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    BtnProducts.frame = CGRectMake(158, 45, 162, 45);
    [backGroundImageView addSubview:BtnProducts];
    
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-50)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 560);
    [backGroundImageView addSubview:scrollview];
  
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }
    
[self recpfetchdataurl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)BtnProductsClick{
    [[DataManager shared] activityIndicatorAnimate:@"Loading..." view:self.view];
    [BtnProducts setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateNormal];
    [BtnRecipe setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [self recpfetchdata];
}
-(void)BtnRecipeClick{
    
    [BtnRecipe setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateNormal];
    [BtnProducts setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [self recpfetchdataurl];
    
}
-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return  [StrText rangeOfString:StrSearchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?FALSE:TRUE;
}
-(void)recpfetchdataurl{
    for(UIView *subview in [scrollview subviews]) {
        
        [subview removeFromSuperview];
    }
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
            NSString *urlString = [NSString stringWithFormat:@"%@getapprovedrecipes", purl];
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
                
                if ( [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                    
                    [[DataManager shared] removeActivityIndicator:self.view];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error! "message:@"Please retry after sometime" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                } else if( [[json objectForKey:@"log"] isEqualToString:@"No recipe is approved yet"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [[DataManager shared] removeActivityIndicator:self.view];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error! "message:@"No recipe is approved yet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    });
                }else if( [[json objectForKey:@"error"] isEqualToString:@"No recipe submitted by this user"]) {
                    [[DataManager shared] removeActivityIndicator:self.view];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error! "message:@"No recipe submitted by this user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
                else{
                    
                    int k=0;
                    NSArray *na=[json objectForKey:@"data"];
                    for (int i=0; i<na.count; i++) {
                        
                    
                    UIButton *topBar = [[UIButton alloc] initWithFrame:CGRectMake(0, k, 320, 50)];
                    topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
                        topBar.tag=[[na[i] objectForKey:@"temp_id"]integerValue];
                    //topBar.tag=[[newDataArray[i] objectForKey:@"recipe_id"] integerValue];
                    [topBar addTarget:self action:@selector(recipeClick:) forControlEvents:UIControlEventTouchUpInside];
                    topBar.userInteractionEnabled = YES;
                    [scrollview addSubview:topBar];
                    
                    UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
                    divider.image=[UIImage imageNamed:@"divider.png"];
                    divider.userInteractionEnabled = YES;
                    [topBar addSubview:divider];
                    UIImageView *umv=[[UIImageView alloc]initWithFrame:CGRectMake(topBar.frame.size.width-40, 4, 35, 35)];
                    umv.image=[UIImage imageNamed:@"list_arrow.png"];
                    [topBar addSubview:umv];
                    
                    
                    AsyncImageView *img=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, 2, 35, 35)];
                    {
                        
                            img.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[na[i] objectForKey:@"image"]]];
                            
                        
                        
                    }
                    
                    img.layer.cornerRadius =  2;
                    img.layer.masksToBounds = YES;
                    [topBar addSubview:img];
                    
                    {
                        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(45, 6, 230, 25)];
                        alphatext.text=[na[i] objectForKey:@"recipe_name"];
                        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                        alphatext.backgroundColor=[UIColor clearColor];
                        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
                        alphatext.textAlignment=NSTextAlignmentLeft;
                        
                        
                        [topBar addSubview:alphatext];
                    }
                         k=k+45;
                    }

                }
                
            }else{
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
                       
-(void)recpfetchdata{
    for(UIView *subview in [scrollview subviews]) {
        
        [subview removeFromSuperview];
        
    }
    
    
    dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
    dispatch_async(q_background, ^{
    
    
    int i=0;
    
    NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM UserRecipeTable"];
    [[DataManager shared]createDB];
    sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
     int k=0;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        {
            
            char *offrName=(char *) sqlite3_column_text(statement, 1);
            NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
            
            UIButton *topBar = [[UIButton alloc] initWithFrame:CGRectMake(0, k, 320, 50)];
            topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
            
            //topBar.tag=[[newDataArray[i] objectForKey:@"recipe_id"] integerValue];
            [topBar addTarget:self action:@selector(recipeClick:) forControlEvents:UIControlEventTouchUpInside];
            topBar.userInteractionEnabled = YES;
            [scrollview addSubview:topBar];
            char *offrid=(char *) sqlite3_column_text(statement, 0);
            NSString *offerid= offrid == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrid];

            topBar.tag=[offerid integerValue];
            UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
            divider.image=[UIImage imageNamed:@"divider.png"];
            divider.userInteractionEnabled = YES;
            [topBar addSubview:divider];
            UIImageView *umv=[[UIImageView alloc]initWithFrame:CGRectMake(topBar.frame.size.width-40, 4, 35, 35)];
            umv.image=[UIImage imageNamed:@"list_arrow.png"];
            [topBar addSubview:umv];
            
           
            AsyncImageView *img=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, 2, 35, 35)];
            {
                char *offrName=(char *) sqlite3_column_text(statement, 5);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
            
                if([self Contains:@"http" on:offerString]){
                  img.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(statement, 5)]];
                }
                else{
                     img.image=[UIImage imageWithContentsOfFile:offerString];
                }
                

                
            }
            
            img.layer.cornerRadius =  2;
            img.layer.masksToBounds = YES;
            [topBar addSubview:img];
            
            {
                UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(45, 6, 230, 25)];
                alphatext.text=offerString;
                alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                alphatext.backgroundColor=[UIColor clearColor];
                alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
                alphatext.textAlignment=NSTextAlignmentLeft;
                
                
                [topBar addSubview:alphatext];
            }
            k=k+45;

            
            
            
        }
         [[DataManager shared]removeActivityIndicator:self.view];
        
    }
   
    });

}
-(void)recipeClick:(id)Sender{
    RecipeDetailsViewController *rcp=[[RecipeDetailsViewController alloc]init];
    rcp.tempId=[@([Sender tag]) stringValue];
    [self.navigationController pushViewController:rcp animated:YES];
    NSLog(@" hit %ld",(long)[Sender tag]);
}
@end
