//
//  productsViewController.m
//  idfinal
//
//  Created by Click Labs on 2/11/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "productsViewController.h"
#include "ProductlistViewController.h"
#include "Reachability.h"
#include "DataManager.h"


@interface productsViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    sqlite3 *db;
    NSArray *newDataArray;
    UIView *uiviewPopup;
    UIView *uiviewPopupover;
    UIPickerView *myPickerView;
    UIDatePicker *myDatePicker;
    UITextField *unametextField;
UITextField *uDatetextField;
    NSMutableArray *ar;
}
@end

@implementation productsViewController

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
    ar=[[NSMutableArray alloc] initWithObjects:nil];
    [super viewDidLoad];
    _mealtype = @[@"BreakFast", @"Lunch",
                      @"Dinner",@"Others"];
    
    NSLog(@"%@ hi",_query);
    newDataArray = [[NSArray alloc] init];
   [self retrieveData];
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
    topBarLabel.text = @"Product List";
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
    
   
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-105)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 560);
    [backGroundImageView addSubview:scrollview];
    [self fetchdata];
    
    UIView *btnbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, 320, 60)];
    btnbar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
    btnbar.userInteractionEnabled = YES;
    [backGroundImageView addSubview:btnbar];
    
    
    
    
   
    
    
    UIButton *btnAddToMeal = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddToMeal addTarget:self
                    action:@selector(btnAddToMealClick)
          forControlEvents:UIControlEventTouchUpInside];
    [btnAddToMeal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    btnAddToMeal.frame = CGRectMake(35, 15, 250, 30);
    [btnbar addSubview:btnAddToMeal];
    UIImageView *btnicn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plusBtn_ipad.png"]];
    btnicn.frame=CGRectMake(50, 0, 30, 30);
    [btnAddToMeal addSubview:btnicn];
    {
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(0, 7, 250, 20)];
        alphatext.text=@"Add to Meal";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:16];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor whiteColor];
        alphatext.textAlignment=NSTextAlignmentCenter;
        [btnAddToMeal addSubview:alphatext];
    }
    
    
    

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }

     //    [[DataManager shared]createDB];
   //[[DataManager shared] delteData:@"Delete from FavProductTable"];
    
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [uiviewPopupover addGestureRecognizer:tapScroll];
    

    
    
   	// Do any additional setup after loading the view.
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
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&productcategoryid=%@",atoken,_query];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@getproductlist", purl];
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
                    
                    newDataArray =[json objectForKey:@"data"];
                    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 50*newDataArray.count+1);
                    for (int i=0; i<newDataArray.count; i++) {
                        
                        UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, 320, 50)];
                        topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
                        topBar.userInteractionEnabled = YES;
                        [scrollview addSubview:topBar];
                        
                        UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
                        divider.image=[UIImage imageNamed:@"divider.png"];
                        divider.userInteractionEnabled = YES;
                        [topBar addSubview:divider];
                       
                        UIButton *selectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        [selectbtn addTarget:self
                                        action:@selector(selectbtnClick:)
                              forControlEvents:UIControlEventTouchUpInside];
                        [selectbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [selectbtn setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
                        [selectbtn setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateHighlighted];
                        selectbtn.frame = CGRectMake(topBar.frame.size.width-66, 4, 35, 35);
                        selectbtn.tag=[[newDataArray[i] objectForKey:@"product_id"] integerValue];
                        [topBar addSubview:selectbtn];
                        
                        UIButton *btnfav = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnfav addTarget:self
                                        action:@selector(btnfavClick:)
                              forControlEvents:UIControlEventTouchUpInside];
                        [btnfav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                       
                       ///database
                        [self openDB];
                        NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM FavProductTable where ProductId='%ld'",(long)[[newDataArray[i] objectForKey:@"product_id"] integerValue]];
                        sqlite3_stmt  *statement;
                        if (sqlite3_prepare(db, [queryString UTF8String], -1, &statement, nil)==SQLITE_OK)
                            
                        {
                            if(sqlite3_step(statement)!=SQLITE_ROW){
                               [btnfav setBackgroundImage:[UIImage imageNamed:@"list_favorites.png"] forState:UIControlStateNormal];
                            }else{
                                [btnfav setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateNormal];
                             }
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(db);


                        
                        
                        [btnfav setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateHighlighted];
                        btnfav.frame = CGRectMake(topBar.frame.size.width-40, 4, 35, 35);
                        btnfav.tag=[[newDataArray[i] objectForKey:@"product_id"] integerValue];
                        [topBar addSubview:btnfav];
                        
                        {
                            UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(20, 6, 250, 25)];
                            alphatext.text=[newDataArray[i] objectForKey:@"product_name"];
                            alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                            alphatext.backgroundColor=[UIColor clearColor];
                            alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
                            alphatext.textAlignment=NSTextAlignmentLeft;
                            alphatext.tag=[[newDataArray[i] objectForKey:@"product_id"] integerValue];

                            [topBar addSubview:alphatext];
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
    
    uiviewPopupover=[[UIView alloc]init ];
    
    
    uiviewPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    uiviewPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    uiviewPopupover.hidden=YES;
    [backGroundImageView addSubview:uiviewPopupover];
    
    
    uiviewPopup=[[UIView alloc]init ];
    
    
    uiviewPopup.frame=CGRectMake(10, (self.view.frame.size.height-148)/2, 300, 148);
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"popup_box.png"] drawInRect:uiviewPopup.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    uiviewPopup.backgroundColor=[UIColor colorWithPatternImage:image];
        [uiviewPopupover addSubview:uiviewPopup];
    
    UIButton *btnClosePopupView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClosePopupView addTarget:self
                          action:@selector(btnClosePopupViewClick)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateNormal];
    [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateHighlighted];
    btnClosePopupView.frame = CGRectMake(280, 10, 10, 10);
    [uiviewPopup addSubview:btnClosePopupView];
    
    
    UIButton *btnAddToMeal = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddToMeal addTarget:self
                     action:@selector(btnaddtomealClick)
           forControlEvents:UIControlEventTouchUpInside];
    [btnAddToMeal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    btnAddToMeal.frame = CGRectMake(60, 105, 180, 25);
    [uiviewPopup addSubview:btnAddToMeal];
    UIImageView *btnicn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plusBtn_ipad.png"]];
    btnicn.frame=CGRectMake(28, 0, 25, 25);
    [btnAddToMeal addSubview:btnicn];
    {
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(0, 4, 180, 20)];
        alphatext.text=@"Add to Meal";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor whiteColor];
        alphatext.textAlignment=NSTextAlignmentCenter;
        [btnAddToMeal addSubview:alphatext];
    }
    {
    UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(10, 28, 100, 20)];
    alphatext.text=@"Set a Date";
    alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
    alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
    
    [uiviewPopup addSubview:alphatext];
        
       myDatePicker= [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 300, 150, 148)];
        [myDatePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
        myDatePicker.datePickerMode=UIDatePickerModeDate;
       // myDatePicker.hidden=YES;
        //[uiviewPopupover addSubview:myDatePicker];
        {
            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 23, 170, 30)];
            nameBackGroundView.image = [UIImage imageNamed:@"setdatebox.png"];
            nameBackGroundView.userInteractionEnabled = YES;
            [uiviewPopup addSubview:nameBackGroundView];
            
        }
        
        uDatetextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 25, 150, 25)];
        uDatetextField.delegate=self;
        uDatetextField.tag=1;
        [uDatetextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        uDatetextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
        uDatetextField.borderStyle = UITextBorderStyleNone;
        uDatetextField.backgroundColor = [UIColor clearColor];
        [uDatetextField setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10]];
        uDatetextField.returnKeyType = UIReturnKeyNext;
        uDatetextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        uDatetextField.text=@"";
        [uDatetextField setInputView:myDatePicker];
        [uiviewPopup addSubview:uDatetextField];
    

       

    }
    {
    UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
    alphatext.text=@"Set a Meal Type";
    alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
    alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
    
    [uiviewPopup addSubview:alphatext];
        
        
        myPickerView = [[UIPickerView alloc] init];
        myPickerView.frame=CGRectMake(0, 300, 150, 148);
        myPickerView.delegate = self;
        myPickerView.backgroundColor=[UIColor clearColor];
        myPickerView.showsSelectionIndicator = YES;
//        myPickerView.hidden=YES;
//        [uiviewPopupover addSubview:myPickerView];
        
        
        {
            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 61, 170, 30)];
            nameBackGroundView.image = [UIImage imageNamed:@"setmealtypebox.png"];
            nameBackGroundView.userInteractionEnabled = YES;
            [uiviewPopup addSubview:nameBackGroundView];
            
        }
        unametextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 64, 150, 25)];
        unametextField.delegate=self;
        unametextField.tag=0;
        [unametextField setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        unametextField.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
        unametextField.borderStyle = UITextBorderStyleNone;
        unametextField.backgroundColor = [UIColor clearColor];
        [unametextField setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10]];
        unametextField.returnKeyType = UIReturnKeyNext;
        unametextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        unametextField.text=@"";
        [unametextField setInputView:myPickerView];
        [uiviewPopup addSubview:unametextField];
    

    }

    //end popup

    
    
    
}
-(void)btnAddToMealClick{
    uiviewPopupover.hidden=NO;
}
-(void)selectbtnClick:(id)Sender{
    for (int i=0; i<newDataArray.count; i++) {
        if([[newDataArray[i] objectForKey:@"product_id"] integerValue]==[Sender tag])
        {
    UIButton *btnselect=(UIButton*)Sender;
    [btnselect setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
            [ar addObject:[newDataArray[i] objectForKey:@"product_name"]];
        }
    }
    
}
-(void)btnfavClick:(id)Sender{
    
    //[[DataManager shared]createDB];
    for (int i=0; i<newDataArray.count; i++) {
        if([[newDataArray[i] objectForKey:@"product_id"] integerValue]==[Sender tag])
        {
                [self openDB];
            NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM FavProductTable where ProductId='%ld'",(long)[[newDataArray[i] objectForKey:@"product_id"] integerValue]];
            sqlite3_stmt  *statement;
             UIButton *btnselect=(UIButton*)Sender;
            if (sqlite3_prepare(db, [queryString UTF8String], -1, &statement, nil)==SQLITE_OK)
                
            {
                if(sqlite3_step(statement)==SQLITE_ROW){
                    sqlite3_finalize(statement);
                    sqlite3_close(db);
                    [btnselect setBackgroundImage:[UIImage imageNamed:@"list_favorites.png"] forState:UIControlStateNormal];
                    [[DataManager shared]createDB];
                    [[DataManager shared]delteData:[NSString stringWithFormat:@"Delete from FavProductTable where ProductId='%ld'",(long)[[newDataArray[i] objectForKey:@"product_id"] integerValue]]];

                }else{
                    [btnselect setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateNormal];
                    sqlite3_finalize(statement);
                    sqlite3_close(db);
                   // sqlite3_reset(statement);
                    [[DataManager shared]createDB];
                    [[DataManager shared]insertData:[NSString stringWithFormat:@"insert into FavProductTable (ProductId,ProductName) values ('%ld','%@')",(long)[Sender tag],[newDataArray[i] objectForKey:@"product_name"]]];
                }
            }

            
            
            
        }
    }
    }
-(void)updateTextField:(id)sender
{
     UIDatePicker *picker = (UIDatePicker*)uDatetextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:picker.date];

   
    uDatetextField.text = theDate;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if(textField.tag==0){
//    myPickerView.hidden=NO;
//        myDatePicker.hidden=YES;
//    }else if(textField.tag==1)
//    {
//        myDatePicker.hidden=NO;
//        myPickerView.hidden=YES;
//    }
//    return NO;  // Hide both keyboard and blinking cursor.
//}
-(void)retrieveData{
    
    [self openDB];
    
   
    NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM UserRecipeTable"];
    sqlite3_stmt  *statement;
    if (sqlite3_prepare(db, [queryString UTF8String], -1, &statement, nil)==SQLITE_OK)
        
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            //6 = category name{
            {
                char *offrName=(char *) sqlite3_column_text(statement, 0);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
                NSLog(@"offer tstamp %@",offerString);
            }
            {
                char *offrName=(char *) sqlite3_column_text(statement, 1);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
                NSLog(@"offer string %@",offerString);
            }
            {
            char *offrName=(char *) sqlite3_column_text(statement, 2);
            NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
            NSLog(@"offer string %@",offerString);
            }
            {
                char *offrName=(char *) sqlite3_column_text(statement, 3);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
                NSLog(@"offer string %@",offerString);
            }
            {
                char *offrName=(char *) sqlite3_column_text(statement, 4);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
                NSLog(@"offer string %@",offerString);
            }
            {
                char *offrName=(char *) sqlite3_column_text(statement, 5);
                NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
                NSLog(@"offer string %@",offerString);
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    else
        NSLog(@"nothing found");
    
}
-(NSString *)filePath{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"IdealAppetitie.db"];
    
}

-(void) openDB{
    
    if (sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK) {
        
        sqlite3_close(db);
        
        NSAssert(0, @"Database Failed to Open");
    }else{
        NSLog(@"Database Opened");
    }
}
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)btnClosePopupViewClick{
    uiviewPopupover.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    unametextField.text=_mealtype[row];
    // Handle the selection
    
}
- (void)pickerChanged:(id)sender
{
    NSString *nsdate=[NSString stringWithFormat:@"%@",[sender date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:[sender date]];
    
    uDatetextField.text=theDate;
    NSLog(@"value: %@",theDate);
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = _mealtype.count;
    
        return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
        return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  _mealtype[row];
}

// tell the picker the title for a given component


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 150;
    return sectionWidth;
}

- (void)tapped

{
    
    
    
    [unametextField resignFirstResponder];
    
    [uDatetextField resignFirstResponder];
    
   
    
}

-(void)btnaddtomealClick{
    uiviewPopupover.hidden=YES;
    [unametextField resignFirstResponder];
    
    [uDatetextField resignFirstResponder];

    [[DataManager shared]  activityIndicatorAnimate:@"Loading..." view:self.view];
    [[DataManager shared]createDB];
    if(unametextField.text!=Nil && uDatetextField.text!=nil){
        for (int i=0; i<ar.count; i++) {
            
        
        [[DataManager shared]insertData:[NSString stringWithFormat:@"insert into MenuPlannerTable (plannerDate,recipeName,recipePlanType,recipeAddType,recipeId,recipeSubcategoryId) values ('%@','%@','%@','ProductType','0','0')",uDatetextField.text,ar[i],unametextField.text]];
        }
        [[DataManager shared] removeActivityIndicator:self.view];

    }
    else{
         [[DataManager shared] removeActivityIndicator:self.view];
    }
    //[[DataManager shared]createDB];
    //[self retrieveData];

}

@end
