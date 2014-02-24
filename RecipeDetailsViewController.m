//
//  RecipeDetailsViewController.m
//  idfinal
//
//  Created by Click Labs on 2/14/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "RecipeDetailsViewController.h"
#import "Reachability.h"
#import "DataManager.h"
#import "RecipeListViewController.h"
#import "AsyncImageView.h"
#import "RecipeAddViewController.h"
#define kOFFSET_FOR_KEYBOARD 90


@interface RecipeDetailsViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    UITextField *txtSearch;
    UILabel *topBarLabel;
    NSArray *newDataArray;
    NSString *rcpid;
    NSString *rcpname;
    NSString *rcpimage;
    UIImageView *rcpimg;
    UITextField  *txtfldcmnt;
    UIView *btnbar;
    UIView *uiviewPopup;
    UIView *uiviewPopupover;
    UIView *uiviewMealPopup;
    UIView *uiviewMealPopupover;
    RateView *rateNow;
    UIPickerView *myPickerView;
    UIDatePicker *myDatePicker;
    UITextField *unametextField;
    UITextField *uDatetextField;
    NSMutableArray *ar;
    
}
@end

@implementation RecipeDetailsViewController

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
    _mealtype = @[@"BreakFast", @"Lunch",
                  @"Dinner",@"Others"];
    

    NSLog(@"%@ sub: %@",_recipeid,_recipesubcategoryid);
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
    topBarLabel.text = @"Loading...";
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
	// Do any additional setup after loading the view.
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-46)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    
    [backGroundImageView addSubview:scrollview];
    
   
    btnbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-35, 320, 35)];
    btnbar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:0.98f];
    btnbar.userInteractionEnabled = YES;
    [backGroundImageView addSubview:btnbar];
    
     txtfldcmnt = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 35)];
    txtfldcmnt.delegate=self;
    txtfldcmnt.placeholder=@"Add a comment";
    txtfldcmnt.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtfldcmnt.borderStyle = UITextBorderStyleNone;txtfldcmnt.textAlignment = NSTextAlignmentLeft;
    txtfldcmnt.backgroundColor = [UIColor clearColor];
    [txtfldcmnt setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtfldcmnt.returnKeyType = UIReturnKeyNext;
    txtfldcmnt.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    [btnbar addSubview:txtfldcmnt];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(addCommentClick)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Add" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    loginButton.frame = CGRectMake(self.view.frame.size.width-50, 0, 50, 35);
    [btnbar addSubview:loginButton];
    
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [scrollview addGestureRecognizer:tapScroll];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            
            
            
        } else
        {
            
            
        }
    }
    if(_tempId!=Nil){
        rcpid=_tempId;
        _recipesubcategoryid=@"4";
    }
	// Do any additional setup after loading the view.
    if(_tempId==Nil){
    [self fetchdata];
    }else{
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton  addTarget:self
                        action:@selector(editClick)
              forControlEvents:UIControlEventTouchUpInside];
        [editButton  setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateNormal];
        [editButton  setBackgroundImage:[UIImage imageNamed:@"edit_btn.png"] forState:UIControlStateHighlighted];
        editButton .frame = CGRectMake(self.view.frame.size.width-50, 0, 45,45);
        [topBar addSubview:editButton];
    [self getdata];
    }
}
-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return  [StrText rangeOfString:StrSearchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?FALSE:TRUE;
}
-(void)editClick{
    RecipeAddViewController *rcp=[[RecipeAddViewController alloc]init];
    rcp.tempsid=_tempId;
    [self.navigationController pushViewController:rcp animated:YES];
}

-(void)getdata{
    NSLog(@"temp id%@",_tempId);
    btnbar.hidden=YES;
    [[DataManager shared]createDB];
    NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM UserRecipeTable where recipeId='%@'",_tempId];
    sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
    while (sqlite3_step(statement)==SQLITE_ROW)
        {
            char *_rname=(char *) sqlite3_column_text(statement, 1);
            NSString *_rcpname= _rname == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rname];
            topBarLabel.text=_rcpname;
            
            char *_rserving=(char *) sqlite3_column_text(statement, 2);
            NSString *_rcpserving= _rserving == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rserving];
        
            char *_rsize=(char *) sqlite3_column_text(statement, 2);
            NSString *_rcpSize= _rsize == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rsize];
            
            char *_rimage=(char *) sqlite3_column_text(statement, 5);
            NSString *_rimg= _rimage == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rimage];
            
            char *_ring=(char *) sqlite3_column_text(statement, 6);
            NSString *_ringredient= _ring == NULL ? nil :[[ NSString alloc]initWithUTF8String:_ring];
            
            char *_rins=(char *) sqlite3_column_text(statement, 4);
            NSString *_rinstru= _rins == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rins];
    
    
    
    UIImageView *topimgview=[[UIImageView alloc]initWithFrame:CGRectMake(-2, 0, self.view.frame.size.width+5, 45)];
    topimgview.image=[UIImage imageNamed:@"reset_password.png"];
    [scrollview addSubview:topimgview];
    {
        int k=((self.view.frame.size.width)/3);
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(0, 6, k-4, 16)];
        alphatext.text=@"Serving";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor whiteColor];;
        alphatext.textAlignment=NSTextAlignmentCenter;
        
        
        [topimgview addSubview:alphatext];
        
        UILabel *alphatexts=[[UILabel alloc]initWithFrame:CGRectMake(0, 23, k-4, 16)];
        alphatexts.text=_rcpserving;
        alphatexts.font = [UIFont fontWithName:@"MyriadPro-Regular" size:13];
        alphatexts.backgroundColor=[UIColor clearColor];
        alphatexts.textColor=[UIColor whiteColor];;
        alphatexts.textAlignment=NSTextAlignmentCenter;
        
        
        [topimgview addSubview:alphatexts];
        
        
        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/3, 0, 1, 45)];
        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
        [scrollview addSubview:imgsep];
    }
    
    {
        int k=((self.view.frame.size.width)/3);
        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake(k, 0, 1, 45)];
        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
        [scrollview addSubview:imgsep];
        
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(k, 6, 80, 16)];
        alphatext.text=@"Size";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor whiteColor];;
        alphatext.textAlignment=NSTextAlignmentCenter;
        
        
        [topimgview addSubview:alphatext];
        
        UILabel *alphatexts=[[UILabel alloc]initWithFrame:CGRectMake(k+5, 23, 70, 16)];
        alphatexts.text=_rcpSize;
        alphatexts.font = [UIFont fontWithName:@"MyriadPro-Regular" size:13];
        alphatexts.backgroundColor=[UIColor clearColor];
        alphatexts.textColor=[UIColor whiteColor];;
        alphatexts.textAlignment=NSTextAlignmentCenter;
        [topimgview addSubview:alphatexts];
        
        
    }
  
    {
        int k=((self.view.frame.size.width)/3)*2;
        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake(k, 0, 1, 45)];
        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
        [scrollview addSubview:imgsep];
        
        
        UIButton *loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loveButton addTarget:self
                       action:@selector(loveClick:)
             forControlEvents:UIControlEventTouchUpInside];
        [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites.png"] forState:UIControlStateNormal];
        [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateHighlighted];
        loveButton.frame = CGRectMake(k+25, -5, 50,50);
        
        [scrollview addSubview:loveButton];
        
        [[DataManager shared]createDB];
        NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM FavouriteTable where recipeId='%@'",_tempId];
        sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
        while (sqlite3_step(statement)==SQLITE_ROW) {
            {
                
                
                [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateNormal];
            }
        }
    
    
    
   

        AsyncImageView *img=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 160)];
    if([self Contains:@"http" on:_rimg]){
        img.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_rimg]];
    }
    else{
        img.image=[UIImage imageWithContentsOfFile:_rimg];
    }
    
    
        [scrollview addSubview:img];
    
    

        UIButton *btnAddToGroccery = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnAddToGroccery addTarget:self
                             action:@selector(loveClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        [btnAddToGroccery setTitle:@"Add to Grocerry" forState:UIControlStateNormal];
        btnAddToGroccery.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
        btnAddToGroccery.tintColor=[UIColor whiteColor];
        btnAddToGroccery.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
        btnAddToGroccery.frame = CGRectMake(10, 145, 140,25);
        
        [scrollview addSubview:btnAddToGroccery];
        
        
        UIButton *btnAddToMeal = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnAddToMeal addTarget:self
                         action:@selector(btnAddToMealClick)
               forControlEvents:UIControlEventTouchUpInside];
        [btnAddToMeal setTitle:@"Add to Meal" forState:UIControlStateNormal];
        btnAddToMeal.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
        btnAddToMeal.tintColor=[UIColor whiteColor];
        btnAddToMeal.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
        btnAddToMeal.frame = CGRectMake(160, 145, 140,25);
        
        [scrollview addSubview:btnAddToMeal];
        UIButton *btnAddToBoath = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnAddToBoath addTarget:self
                          action:@selector(loveClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [btnAddToBoath setTitle:@"Add to Boath" forState:UIControlStateNormal];
        btnAddToBoath.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
        btnAddToBoath.tintColor=[UIColor whiteColor];
        btnAddToBoath.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
        btnAddToBoath.frame = CGRectMake(10, 175, 290,25);
        
        [scrollview addSubview:btnAddToBoath];


      


        //ingredient
        UIImageView *ingredientBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 205, self.view.frame.size.width, 35)];
        ingredientBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
        ingredientBar.userInteractionEnabled = YES;
        [scrollview addSubview:ingredientBar];
        
        UILabel *lblingredient = [[UILabel alloc] init];
        lblingredient.textColor = [UIColor blackColor];
        lblingredient.lineBreakMode = NSLineBreakByWordWrapping;
        lblingredient.numberOfLines = 1;
        lblingredient.textAlignment =NSTextAlignmentLeft;
        lblingredient.text=@"Ingredients";//[newDataArray[0] objectForKey:@"name"];
        lblingredient.backgroundColor=[UIColor clearColor];
        lblingredient.textColor=[UIColor whiteColor];
        lblingredient.frame=CGRectMake(20, 5, self.view.frame.size.width, 25);
        [lblingredient setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
        
        [ingredientBar addSubview:lblingredient];

        
//        NSArray *ns=[newDataArray[0] objectForKey:@"Ingredients"];
//        NSMutableString* theString = [NSMutableString string];
//        int ims=0;
//        for(ims=0;ims<ns.count;ims++){
//            NSLog(@"%@",[ns[ims] objectForKey:@"ingredient_text"]);
//            [theString appendString:[NSString stringWithFormat:@"%@ \n",[ns[ims] objectForKey:@"ingredient_text"]]];
//        }
    

        _ringredient=[_ringredient stringByReplacingOccurrencesOfString:@","
                                                    withString:@" \n"];
        UILabel *ingr=[[UILabel alloc]initWithFrame:CGRectMake(10, 245, self.view.frame.size.width-20, 1.0f)];
        
        ingr.text = _ringredient;
                ingr.textColor = [UIColor blackColor];
                ingr.lineBreakMode = NSLineBreakByWordWrapping;
                ingr.numberOfLines = 0;
                ingr.textAlignment =NSTextAlignmentLeft;
                ingr.backgroundColor=[UIColor clearColor];
                [ingr setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:11]];
                [ingr sizeToFit];

        [scrollview addSubview:ingr];
        
        

        {
            UIImageView *ingredientBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250+ingr.frame.size.height, self.view.frame.size.width, 35)];
            ingredientBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
            ingredientBar.userInteractionEnabled = YES;
            [scrollview addSubview:ingredientBar];
            
            UILabel *lblingredient = [[UILabel alloc] init];
            lblingredient.textColor = [UIColor blackColor];
            lblingredient.lineBreakMode = NSLineBreakByWordWrapping;
            lblingredient.numberOfLines = 1;
            lblingredient.textAlignment =NSTextAlignmentLeft;
            lblingredient.text=@"Instructions";//[newDataArray[0] objectForKey:@"name"];
            lblingredient.backgroundColor=[UIColor clearColor];
            lblingredient.textColor=[UIColor whiteColor];
            lblingredient.frame=CGRectMake(20, 5, self.view.frame.size.width, 25);
            
            [lblingredient setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
            
            [ingredientBar addSubview:lblingredient];
            
        }
           UILabel *lblrcpdesc = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 290+ingr.frame.size.height,self.view.frame.size.width-20, 2.0f)];
        lblrcpdesc.text = _rinstru;
        lblrcpdesc.textColor = [UIColor blackColor];
        lblrcpdesc.lineBreakMode = NSLineBreakByWordWrapping;
        lblrcpdesc.numberOfLines = 0;
        lblrcpdesc.textAlignment =NSTextAlignmentLeft;
        lblrcpdesc.backgroundColor=[UIColor clearColor];
        [lblrcpdesc setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:11]];
        [lblrcpdesc sizeToFit];
        [scrollview addSubview:lblrcpdesc];
                scrollview.contentSize=CGSizeMake(self.view.frame.size.width, lblrcpdesc.frame.size.height+60);
  
    uiviewPopupover=[[UIView alloc]init ];
    
    
    uiviewPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    uiviewPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    uiviewPopupover.hidden=YES;
    [scrollview addSubview:uiviewPopupover];
    
    
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
    
    rateNow=[[RateView alloc] initWithFrame:CGRectMake(20, 30, 270, 25)];
    rateNow.notSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
    rateNow.halfSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
    rateNow.fullSelectedImage = [UIImage imageNamed:@"comment_star.png"];
    rateNow.rating = 0;
    rateNow.editable = YES;
    rateNow.maxRating = 5;
    rateNow.delegate = self;
    rateNow.userInteractionEnabled=YES;
    [uiviewPopup addSubview:rateNow];
    
    
    //
    UIButton *btnRate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRate addTarget:self
                action:@selector(btnRateClick)
      forControlEvents:UIControlEventTouchUpInside];
    [btnRate setTitle:@"Done" forState:UIControlStateNormal];
    [btnRate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRate.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    
    [btnRate setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [btnRate setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
    btnRate.frame = CGRectMake(45, 80, 200, 25);
    [uiviewPopup addSubview:btnRate];
    
    [self addMealPopup];
    
   
    }}
    
    
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
            
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&recipeid=%@&recipesubcategoryid=%@&devicetype=%@",atoken,_recipeid,_recipesubcategoryid,@"1"];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@getrecipedetails", purl];
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
                    topBarLabel.text=[newDataArray[0] objectForKey:@"recipe_name"];
                    UIImageView *topimgview=[[UIImageView alloc]initWithFrame:CGRectMake(-2, 0, self.view.frame.size.width+5, 45)];
                    topimgview.image=[UIImage imageNamed:@"reset_password.png"];
                    [scrollview addSubview:topimgview];
                    {
                        int k=((self.view.frame.size.width)/4);
                        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(0, 6, k-4, 16)];
                        alphatext.text=@"Serving";
                        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                        alphatext.backgroundColor=[UIColor clearColor];
                        alphatext.textColor=[UIColor whiteColor];;
                        alphatext.textAlignment=NSTextAlignmentCenter;
                        
                        
                        [topimgview addSubview:alphatext];
                       
                        UILabel *alphatexts=[[UILabel alloc]initWithFrame:CGRectMake(0, 23, k-4, 16)];
                        alphatexts.text=[newDataArray[0] objectForKey:@"servings"];;
                        alphatexts.font = [UIFont fontWithName:@"MyriadPro-Regular" size:13];
                        alphatexts.backgroundColor=[UIColor clearColor];
                        alphatexts.textColor=[UIColor whiteColor];;
                        alphatexts.textAlignment=NSTextAlignmentCenter;
                        
                        
                        [topimgview addSubview:alphatexts];

                        
                        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/4, 0, 1, 45)];
                        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
                        [scrollview addSubview:imgsep];
                                           }
                    
                    {
                        int k=((self.view.frame.size.width)/4);
                        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake(k, 0, 1, 45)];
                        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
                        [scrollview addSubview:imgsep];
                        
                        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(k, 6, 80, 16)];
                        alphatext.text=@"Size";
                        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                        alphatext.backgroundColor=[UIColor clearColor];
                        alphatext.textColor=[UIColor whiteColor];;
                        alphatext.textAlignment=NSTextAlignmentCenter;
                        
                        
                        [topimgview addSubview:alphatext];
                        
                        UILabel *alphatexts=[[UILabel alloc]initWithFrame:CGRectMake(k+5, 23, 70, 16)];
                        alphatexts.text=[newDataArray[0] objectForKey:@"size"];
                        alphatexts.font = [UIFont fontWithName:@"MyriadPro-Regular" size:13];
                        alphatexts.backgroundColor=[UIColor clearColor];
                        alphatexts.textColor=[UIColor whiteColor];;
                        alphatexts.textAlignment=NSTextAlignmentCenter;
                        [topimgview addSubview:alphatexts];


                    }
                    {
                        int k=((self.view.frame.size.width)/4)*2;
                        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake(k, 0, 1, 45)];
                        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
                        [scrollview addSubview:imgsep];
                        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(k, 6, 80, 16)];
                        alphatext.text=@"Rate Now";
                        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
                        alphatext.backgroundColor=[UIColor clearColor];
                        alphatext.textColor=[UIColor whiteColor];;
                        alphatext.textAlignment=NSTextAlignmentCenter;
                        
                        
                        [topimgview addSubview:alphatext];
                        
                        UILabel *alphatexts=[[UILabel alloc]initWithFrame:CGRectMake(k+5, 23, 70, 16)];
                        alphatexts.text=[NSString stringWithFormat:@"%@",[newDataArray[0] objectForKey:@"recipe_ratings"]];
                        alphatexts.font = [UIFont fontWithName:@"MyriadPro-Regular" size:13];
                        alphatexts.backgroundColor=[UIColor clearColor];
                        alphatexts.textColor=[UIColor whiteColor];;
                        alphatexts.textAlignment=NSTextAlignmentCenter;
                        [topimgview addSubview:alphatexts];
                        rcpid=[NSString stringWithFormat:@"%@",[newDataArray[0] objectForKey:@"recipe_id"]];
                        rcpname=[NSString stringWithFormat:@"%@",[newDataArray[0] objectForKey:@"recipe_name"]];
                        rcpimage=[NSString stringWithFormat:@"%@",[newDataArray[0] objectForKey:@"image"]];

                    }
                    {
                         int k=((self.view.frame.size.width)/4)*3;
                        UIImageView *imgsep=[[UIImageView alloc]initWithFrame:CGRectMake(k, 0, 1, 45)];
                        imgsep.image=[UIImage imageNamed:@"divider_bottom.png"];
                        [scrollview addSubview:imgsep];
                        
                        
                        UIButton *loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [loveButton addTarget:self
                                       action:@selector(loveClick:)
                             forControlEvents:UIControlEventTouchUpInside];
                        [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites.png"] forState:UIControlStateNormal];
                        [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateHighlighted];
                        loveButton.frame = CGRectMake(k+15, -5, 50,50);
                        
                        [scrollview addSubview:loveButton];
                        
                        [[DataManager shared]createDB];
                        NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM FavouriteTable where recipeId='%@'",rcpid];
                        sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
                        while (sqlite3_step(statement)==SQLITE_ROW) {
                            {
                                
                            
                                [loveButton setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateNormal];
                            }
                        }
                        
                        AsyncImageView *im=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 160)];
                        im.imageURL=[NSURL URLWithString:rcpimage];
                        [scrollview addSubview:im];
                        
                        
                        UIButton *btnAddToGroccery = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnAddToGroccery addTarget:self
                                       action:@selector(loveClick:)
                             forControlEvents:UIControlEventTouchUpInside];
                        [btnAddToGroccery setTitle:@"Add to Grocerry" forState:UIControlStateNormal];
                        btnAddToGroccery.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
                        btnAddToGroccery.tintColor=[UIColor whiteColor];
                         btnAddToGroccery.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
                        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
                        btnAddToGroccery.frame = CGRectMake(10, 145, 140,25);
                        
                        [scrollview addSubview:btnAddToGroccery];
                        
                        
                        UIButton *btnAddToMeal = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnAddToMeal addTarget:self
                                             action:@selector(btnAddToMealClick)
                                   forControlEvents:UIControlEventTouchUpInside];
                        [btnAddToMeal setTitle:@"Add to Meal" forState:UIControlStateNormal];
                        btnAddToMeal.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
                        btnAddToMeal.tintColor=[UIColor whiteColor];
                        btnAddToMeal.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
                        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
                        btnAddToMeal.frame = CGRectMake(160, 145, 140,25);
                        
                        [scrollview addSubview:btnAddToMeal];
                        UIButton *btnAddToBoath = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnAddToBoath addTarget:self
                                         action:@selector(loveClick:)
                               forControlEvents:UIControlEventTouchUpInside];
                        [btnAddToBoath setTitle:@"Add to Boath" forState:UIControlStateNormal];
                        btnAddToBoath.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
                        btnAddToBoath.tintColor=[UIColor whiteColor];
                        btnAddToBoath.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
                        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
                        btnAddToBoath.frame = CGRectMake(10, 175, 140,25);
                        
                        [scrollview addSubview:btnAddToBoath];
                        
                        UIButton *btnRateNow = [UIButton buttonWithType:UIButtonTypeCustom];
                        [btnRateNow addTarget:self
                                          action:@selector(btnRateNowClick)
                                forControlEvents:UIControlEventTouchUpInside];
                        [btnRateNow setTitle:@"Rate Now" forState:UIControlStateNormal];
                        btnRateNow.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f];
                        btnRateNow.tintColor=[UIColor whiteColor];
                        btnRateNow.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
                        //[btnAddToGroccery setFont:[UIFont fontWithName:@"MyriadPro-Light" size:15]];
                        btnRateNow.frame = CGRectMake(160, 175, 140,25);
                        
                        [scrollview addSubview:btnRateNow];
                        
                        //ingredient
                        UIImageView *ingredientBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 205, self.view.frame.size.width, 35)];
                        ingredientBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                        ingredientBar.userInteractionEnabled = YES;
                        [scrollview addSubview:ingredientBar];
                        
                        UILabel *lblingredient = [[UILabel alloc] init];
                        lblingredient.textColor = [UIColor blackColor];
                        lblingredient.lineBreakMode = NSLineBreakByWordWrapping;
                        lblingredient.numberOfLines = 1;
                        lblingredient.textAlignment =NSTextAlignmentLeft;
                        lblingredient.text=@"Ingredients";//[newDataArray[0] objectForKey:@"name"];
                        lblingredient.backgroundColor=[UIColor clearColor];
                        lblingredient.textColor=[UIColor whiteColor];
                        lblingredient.frame=CGRectMake(20, 5, self.view.frame.size.width, 25);
                        [lblingredient setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        
                        [ingredientBar addSubview:lblingredient];
                        
                        NSArray *ns=[newDataArray[0] objectForKey:@"Ingredients"];
                        NSMutableString* theString = [NSMutableString string];
                        int ims=0;
                        for(ims=0;ims<ns.count;ims++){
                            NSLog(@"%@",[ns[ims] objectForKey:@"ingredient_text"]);
                            [theString appendString:[NSString stringWithFormat:@"%@ \n",[ns[ims] objectForKey:@"ingredient_text"]]];
                        }
                        
                        NSLog(@"%@",theString);
                        UILabel *ingr=[[UILabel alloc]initWithFrame:CGRectMake(10, 245, self.view.frame.size.width, 10*ims)];
                        
                        ingr.lineBreakMode = NSLineBreakByWordWrapping;
                        ingr.numberOfLines = ims;
                        ingr.textAlignment =NSTextAlignmentLeft;
                        ingr.text=theString;
                        ingr.backgroundColor=[UIColor clearColor];
                        ingr.textColor=[UIColor blackColor];
                        [ingr setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:11]];
                        ingr.userInteractionEnabled=NO;
                        [scrollview addSubview:ingr];
                        ims=10*ims;
                        
                        {
                            UIImageView *ingredientBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250+ims, self.view.frame.size.width, 35)];
                            ingredientBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                            ingredientBar.userInteractionEnabled = YES;
                            [scrollview addSubview:ingredientBar];
                            
                            UILabel *lblingredient = [[UILabel alloc] init];
                            lblingredient.textColor = [UIColor blackColor];
                            lblingredient.lineBreakMode = NSLineBreakByWordWrapping;
                            lblingredient.numberOfLines = 1;
                            lblingredient.textAlignment =NSTextAlignmentLeft;
                            lblingredient.text=@"Instructions";//[newDataArray[0] objectForKey:@"name"];
                            lblingredient.backgroundColor=[UIColor clearColor];
                            lblingredient.textColor=[UIColor whiteColor];
                            lblingredient.frame=CGRectMake(20, 5, self.view.frame.size.width, 25);
                            [lblingredient setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                            
                            [ingredientBar addSubview:lblingredient];

                        }
                        UILabel *lblrcpdesc = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 290+ims,self.view.frame.size.width-20, 2.0f)];
                        lblrcpdesc.text = [newDataArray[0] objectForKey:@"instructions"];
                        lblrcpdesc.textColor = [UIColor blackColor];
                        lblrcpdesc.lineBreakMode = NSLineBreakByWordWrapping;
                        lblrcpdesc.numberOfLines = 0;
                        lblrcpdesc.textAlignment =NSTextAlignmentLeft;
                                               lblrcpdesc.backgroundColor=[UIColor clearColor];
                        [lblrcpdesc setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:11]];
                        [lblrcpdesc sizeToFit];
                          [scrollview addSubview:lblrcpdesc];
                        
                        UIImageView *commentBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 295+ims+lblrcpdesc.frame.size.height, self.view.frame.size.width, 35)];
                        commentBar.image = [UIImage imageNamed:@"sub_header_ipad.png"];
                        commentBar.userInteractionEnabled = YES;
                        [scrollview addSubview:commentBar];
                        
                        UILabel *lblcomment = [[UILabel alloc] init];
                        lblcomment.textColor = [UIColor blackColor];
                        lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
                        lblcomment.numberOfLines = 1;
                        lblcomment.textAlignment =NSTextAlignmentLeft;
                        lblcomment.text=@"Comments";//[newDataArray[0] objectForKey:@"name"];
                        lblcomment.backgroundColor=[UIColor clearColor];
                        lblcomment.textColor=[UIColor whiteColor];
                        lblcomment.textAlignment=NSTextAlignmentJustified;
                        lblcomment.frame=CGRectMake(20, 5, self.view.frame.size.width, 25);
                        [lblcomment setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
                        
                        [commentBar addSubview:lblcomment];
                        float y=commentBar.frame.origin.y+35;
                        if(![@"0" isEqualToString:[NSString stringWithFormat:@"%@",[newDataArray[0] objectForKey:@"Comments"]]]){
                        NSArray *nsComment=[newDataArray[0] objectForKey:@"Comments"];
                        if(nsComment.count!=0)
                        for(int cmnt=0;cmnt<nsComment.count;cmnt++){
                            UIView *cmntView=[[UIView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
                            
                            cmntView.backgroundColor=[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
                            AsyncImageView *img=[[AsyncImageView alloc]initWithFrame:CGRectMake(5, 2, 35, 35)];
                            img.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[nsComment[cmnt] objectForKey:@"image"]]];
                            img.layer.cornerRadius =  2;
                            img.layer.masksToBounds = YES;
                            [cmntView addSubview:img];
                            
                            
                            [scrollview addSubview:cmntView];
                            
                            UILabel *lblcomment = [[UILabel alloc] init];
                            lblcomment.textColor = [UIColor blackColor];
                            lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
                            lblcomment.numberOfLines = 1;
                            lblcomment.textAlignment =NSTextAlignmentLeft;
                            lblcomment.text=@"Posted By: ";//[newDataArray[0] objectForKey:@"name"];
                            lblcomment.backgroundColor=[UIColor clearColor];
                            lblcomment.textColor=[UIColor grayColor];
                            lblcomment.textAlignment=NSTextAlignmentJustified;
                            lblcomment.frame=CGRectMake(50, 5, 50, 12);
                            [lblcomment setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12]];
                            [cmntView addSubview:lblcomment];
                            
                            UILabel *lblusename = [[UILabel alloc] init];
                            lblusename.textColor = [UIColor blackColor];
                            lblusename.lineBreakMode = NSLineBreakByWordWrapping;
                            lblusename.numberOfLines = 1;
                            lblusename.textAlignment =NSTextAlignmentLeft;
                            lblusename.text=[NSString stringWithFormat:@"%@",[nsComment[cmnt] objectForKey:@"username"]];
                            lblusename.backgroundColor=[UIColor clearColor];
                            lblusename.textColor=[UIColor blackColor];
                            lblusename.textAlignment=NSTextAlignmentJustified;
                            lblusename.frame=CGRectMake(100, 5, 80, 12);
                            [lblusename setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:12]];
                            [cmntView addSubview:lblusename];
                            
                            UILabel *lblcmnt = [[UILabel alloc] init];
                            lblcmnt.textColor = [UIColor blackColor];
                            lblcmnt.lineBreakMode = NSLineBreakByWordWrapping;
                            lblcmnt.numberOfLines = 1;
                            lblcmnt.textAlignment =NSTextAlignmentLeft;
                            lblcmnt.text=[NSString stringWithFormat:@"%@",[nsComment[cmnt] objectForKey:@"message"]];
                            lblcmnt.backgroundColor=[UIColor clearColor];
                            lblcmnt.textColor=[UIColor blackColor];
                            lblcmnt.textAlignment=NSTextAlignmentJustified;
                            lblcmnt.frame=CGRectMake(50, 18, 80, 12);
                            [lblcmnt setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12]];
                            [cmntView addSubview:lblcmnt];
                            
                            RateView *rateView=[[RateView alloc] initWithFrame:CGRectMake(220, 0, 100, 25)];
                            rateView.notSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
                            rateView.halfSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
                            rateView.fullSelectedImage = [UIImage imageNamed:@"comment_star.png"];
                            rateView.rating = [[NSString stringWithFormat:@"%@",[nsComment[cmnt] objectForKey:@"rating"]] integerValue];
                            rateView.editable = YES;
                            rateView.maxRating = 5;
                            rateView.delegate = self;
                            rateView.userInteractionEnabled=NO;
                            [cmntView addSubview:rateView];
                            
                            
                                                       y=y+60;
                        }
                            
                        
                        
                        }
                        scrollview.contentSize=CGSizeMake(self.view.frame.size.width, y+60);
                    }
                    
                    
                    uiviewPopupover=[[UIView alloc]init ];
                    
                    
                    uiviewPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                    
                    uiviewPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
                    uiviewPopupover.hidden=YES;
                    [scrollview addSubview:uiviewPopupover];
                    
                    
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
                    
                    rateNow=[[RateView alloc] initWithFrame:CGRectMake(20, 30, 270, 25)];
                    rateNow.notSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
                    rateNow.halfSelectedImage = [UIImage imageNamed:@"comment_star_before.png"];
                    rateNow.fullSelectedImage = [UIImage imageNamed:@"comment_star.png"];
                    rateNow.rating = 0;
                    rateNow.editable = YES;
                    rateNow.maxRating = 5;
                    rateNow.delegate = self;
                    rateNow.userInteractionEnabled=YES;
                    [uiviewPopup addSubview:rateNow];
                    
                    
                    //
                    UIButton *btnRate = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btnRate addTarget:self
                                    action:@selector(btnRateClick)
                          forControlEvents:UIControlEventTouchUpInside];
                    [btnRate setTitle:@"Done" forState:UIControlStateNormal];
                    [btnRate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    btnRate.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
                    
                    [btnRate setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
                    [btnRate setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"] forState:UIControlStateHighlighted];
                    btnRate.frame = CGRectMake(45, 80, 200, 25);
                    [uiviewPopup addSubview:btnRate];
                    
                    [self addMealPopup];

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
    
//    rcpimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 120)];
//    rcpimg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:rcpimage]]];
//    [scrollview addSubview:rcpimg];
    
    
    
    
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rateView:(RateView *)rateView ratingDidChange:(float)rating{
    
}
-(void)loveClick:(id)Sender{
    UIButton *btn=(UIButton*)Sender;
    

    
    [[DataManager shared]createDB];
    NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM FavouriteTable where recipeId='%@'",rcpid];
    sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
    int i=0;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        {
            i=1;
            char *offrName=(char *) sqlite3_column_text(statement, 0);
            NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
            NSLog(@"offer tstamp %@",offerString);
        }
    }
    [[DataManager shared]createDB];
    if(i==0){
        [[DataManager shared]insertData:[NSString stringWithFormat:@"insert into FavouriteTable (recipeId,recipeName,recipeImage,recipeType,recipeSubcategoryId) values ('%@','%@','%@','%@','%@')",rcpid,rcpname,rcpimage,@"recipeType",_recipesubcategoryid]];
        [btn setBackgroundImage:[UIImage imageNamed:@"list_favorites_onclick.png"] forState:UIControlStateNormal];
    }else{
        [[DataManager shared]delteData:[NSString stringWithFormat:@"Delete FROM FavouriteTable where recipeId='%@'",rcpid]];
        [btn setBackgroundImage:[UIImage imageNamed:@"list_favorites.png"] forState:UIControlStateNormal];
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapped

{
    
    [unametextField resignFirstResponder];
    [txtfldcmnt resignFirstResponder];
    [uDatetextField resignFirstResponder];
    
    
    
}
-(void)keyboardWillShow {
    CGRect keyboardFrame = [self.view convertRect:keyboardFrame toView:nil];
    
    int k=keyboardFrame.size.height;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    uiviewMealPopup.frame=CGRectMake(uiviewMealPopup.frame.origin.x, ((self.view.frame.size.height-148)/2)-90, uiviewMealPopup.frame.size.width, uiviewMealPopup.frame.size.height);
     btnbar.frame=CGRectMake(0, self.view.frame.size.height-250, 320, 35);
    [UIView commitAnimations];
    
}


-(void)keyboardWillHide {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    btnbar.frame=CGRectMake(0, self.view.frame.size.height-35, 320, 35);
    uiviewMealPopup.frame=CGRectMake(uiviewMealPopup.frame.origin.x, (self.view.frame.size.height-148)/2, uiviewMealPopup.frame.size.width, uiviewMealPopup.frame.size.height);
     [UIView commitAnimations];
}
-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [txtfldcmnt becomeFirstResponder];
            
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

-(void)addCommentClick{
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if ([txtfldcmnt.text length] == 0  ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else
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
            NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&recipeid=%@&comment=%@&recipesubcategoryid=%@",atoken, _recipeid, txtfldcmnt.text,_recipesubcategoryid];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSString *urlString = [NSString stringWithFormat:@"%@addrecipecomment", purl];
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
                if ([[json objectForKey:@"error"] isEqualToString:@"Unable to add comment"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[DataManager shared] removeActivityIndicator:self.view];
                                               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Unable to add comment" message:@"Please retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    });
                }else if([[json objectForKey:@"log"] isEqualToString:@"Comment added successfully"]){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[DataManager shared] removeActivityIndicator:self.view];
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"successfully Done" message:@"Comment added successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                        txtfldcmnt.text=@"";
                        [txtfldcmnt resignFirstResponder];
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

-(void)btnRateNowClick{
    NSLog(@"hi");
     uiviewPopupover.hidden=NO;
}
-(void)btnRateClick{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (rateNow.rating == 0 ) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else
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
                NSString *post =[NSString stringWithFormat:@"useraccesstoken=%@&recipeid=%@&ratestars=%f&recipesubcategoryid=%@",atoken, _recipeid, rateNow.rating,_recipesubcategoryid];
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                NSString *urlString = [NSString stringWithFormat:@"%@raterecipe", purl];
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
                    if ([[json objectForKey:@"error"] isEqualToString:@"Unable to update recipe ratings"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[DataManager shared] removeActivityIndicator:self.view];
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Unable to update recipe ratings" message:@"Please retry!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                        });
                    }else if([[json objectForKey:@"log"] isEqualToString:@"Recipe ratings updated Successfully"]){
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[DataManager shared] removeActivityIndicator:self.view];
                            uiviewPopupover.hidden=YES;
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"successfully Done" message:@"Recipe ratings updated Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
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

-(void)btnClosePopupViewClick{
    uiviewPopupover.hidden=YES;
    uiviewMealPopupover.hidden=YES;
     btnbar.hidden=NO;
}
-(void)addMealPopup{
    uiviewMealPopupover=[[UIView alloc]init ];
    
    
    uiviewMealPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    uiviewMealPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    uiviewMealPopupover.hidden=YES;
    [scrollview addSubview:uiviewMealPopupover];
    
    
    uiviewMealPopup=[[UIView alloc]init ];
    
    
    uiviewMealPopup.frame=CGRectMake(10, (self.view.frame.size.height-148)/2, 300, 148);
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"popup_box.png"] drawInRect:uiviewMealPopup.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    uiviewMealPopup.backgroundColor=[UIColor colorWithPatternImage:image];
    [uiviewMealPopupover addSubview:uiviewMealPopup];
    
    UIButton *btnClosePopupView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClosePopupView addTarget:self
                          action:@selector(btnClosePopupViewClick)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateNormal];
    [btnClosePopupView setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateHighlighted];
    btnClosePopupView.frame = CGRectMake(280, 10, 10, 10);
    [uiviewMealPopup addSubview:btnClosePopupView];
    
    
    UIButton *btnAddToMeal = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddToMeal addTarget:self
                     action:@selector(btnaddtomealClick)
           forControlEvents:UIControlEventTouchUpInside];
    [btnAddToMeal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateNormal];
    [btnAddToMeal setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    btnAddToMeal.frame = CGRectMake(60, 105, 180, 25);
    [uiviewMealPopup addSubview:btnAddToMeal];
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
        
        [uiviewMealPopup addSubview:alphatext];
        
        myDatePicker= [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 300, 150, 148)];
        [myDatePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
        myDatePicker.datePickerMode=UIDatePickerModeDate;
        // myDatePicker.hidden=YES;
        //[uiviewPopupover addSubview:myDatePicker];
        {
            UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 23, 170, 30)];
            nameBackGroundView.image = [UIImage imageNamed:@"setdatebox.png"];
            nameBackGroundView.userInteractionEnabled = YES;
            [uiviewMealPopup addSubview:nameBackGroundView];
            
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
        [uiviewMealPopup addSubview:uDatetextField];
        
        
        
        
    }
    {
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
        alphatext.text=@"Set a Meal Type";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
        
        [uiviewMealPopup addSubview:alphatext];
        
        
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
            [uiviewMealPopup addSubview:nameBackGroundView];
            
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
        [uiviewMealPopup addSubview:unametextField];
        
        
    }
    

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
-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)uDatetextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:picker.date];
    
    
    uDatetextField.text = theDate;
}
-(void)btnAddToMealClick{
    uiviewMealPopupover.hidden=NO;
    btnbar.hidden=YES;
}
-(void)btnaddtomealClick{
    uiviewMealPopupover.hidden=YES;
    [unametextField resignFirstResponder];
    
    [uDatetextField resignFirstResponder];
    
    [[DataManager shared]  activityIndicatorAnimate:@"Loading..." view:self.view];
    [[DataManager shared]createDB];
    if(unametextField.text!=Nil && uDatetextField.text!=nil){
        
       
            [[DataManager shared]insertData:[NSString stringWithFormat:@"insert into MenuPlannerTable (plannerDate,recipeName,recipePlanType,recipeAddType,recipeId,recipeSubcategoryId) values ('%@','%@','%@','RecipeType','%@','%@')",uDatetextField.text,rcpname,unametextField.text,_recipeid,_recipesubcategoryid]];
        
        [[DataManager shared] removeActivityIndicator:self.view];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Add to Meal Success" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    else{
        [[DataManager shared] removeActivityIndicator:self.view];
    }
    //[[DataManager shared]createDB];
    //[self retrieveData];
}
@end
