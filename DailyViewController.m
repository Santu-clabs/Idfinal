//
//  DailyViewController.m
//  idfinal
//
//  Created by Click Labs on 2/19/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "DailyViewController.h"
#import "DataManager.h"
#define kOFFSET_FOR_KEYBOARD 150

@interface DailyViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    UITextField *txtWater;
    NSArray *nsar;
    NSMutableDictionary *ns;
    UITextField *txtActivity;
    UITextField *txtDuration;
    UIView *exerBar;
    UIButton *btnSave;
    UIButton *selectbtns;
    UIDatePicker *myDatePicker;
    UIButton *notbtn;
    UITextField *txtdt;
}
@end

@implementation DailyViewController

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
    ns=[[NSMutableDictionary alloc]init];
    nsar=[[NSArray alloc]initWithObjects:@"Multi Vitamin",@"Cal Mag",@"Postassium",@"Omega",@"Anti Oxident",@"Enzymes", nil];
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
    topBarLabel.text = @"Daily";
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
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 116, self.view.frame.size.width, self.view.frame.size.height-115)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.backgroundColor=[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
    [backGroundImageView addSubview:scrollview];
    
    
    {
        UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 45, self.view.frame.size.width+10, 40)];
        nameBackGroundView.image = [UIImage imageNamed:@"setdatebox.png"];
        nameBackGroundView.userInteractionEnabled = YES;
        [backGroundImageView addSubview:nameBackGroundView];
        
    }
    
    
    
    myDatePicker= [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 300, 150, 148)];
    [myDatePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"popup_box.png"] drawInRect:myDatePicker.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    myDatePicker.backgroundColor=[UIColor colorWithPatternImage:image];
    myDatePicker.datePickerMode=UIDatePickerModeDate;
    
    txtdt = [[UITextField alloc] initWithFrame:CGRectMake(10, 48, self.view.frame.size.width-30, 35)];
    txtdt.delegate=self;
    txtdt.placeholder=@"Today";
    txtdt.tag=1;
    txtdt.textColor = [UIColor blackColor];
    txtdt.borderStyle = UITextBorderStyleNone;
    txtdt.backgroundColor = [UIColor clearColor];
    [txtdt setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15]];
    txtdt.returnKeyType = UIReturnKeyNext;
    txtdt.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    txtdt.text=dateString;
    txtdt.inputView=myDatePicker;
    [backGroundImageView addSubview:txtdt];
    
    
    
    
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
    [self fetchdata];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [backGroundImageView addGestureRecognizer:tapScroll];
	// Do any additional setup after loading the view.
}
- (void)pickerChanged:(id)sender
{
    NSString *nsdate=[NSString stringWithFormat:@"%@",[sender date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:[sender date]];
    
    txtdt.text=theDate;
    NSLog(@"value: %@",theDate);
    [self fetchdata];
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
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fetchdata{
    for(UIView *subview in [scrollview subviews]) {
        
        [subview removeFromSuperview];
        
    }
    {
        UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 85, self.view.frame.size.width+10, 30)];
        nameBackGroundView.image = [UIImage imageNamed:@"reset_password.png"];
        nameBackGroundView.userInteractionEnabled = YES;
        [backGroundImageView addSubview:nameBackGroundView];
        
    }
    
    txtWater = [[UITextField alloc] initWithFrame:CGRectMake(10, 88, self.view.frame.size.width-30, 25)];
    txtWater.delegate=self;
    txtWater.placeholder=@"Water intake in ounce";
    txtWater.tag=1;
    txtWater.textColor = [UIColor whiteColor];
    txtWater.borderStyle = UITextBorderStyleNone;
    txtWater.backgroundColor = [UIColor clearColor];
    [txtWater setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15]];
    txtWater.returnKeyType = UIReturnKeyNext;
    txtWater.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [[DataManager shared]createDB];
    sqlite3_stmt *st=[[DataManager shared] fetchData:[NSString stringWithFormat:@"select * from DailyTable where dailyDate='%@' and dailyType='%@'",txtdt.text,@"Water"]];
    txtWater.text=@"hi";
    while (sqlite3_step(st)==SQLITE_ROW)
    {
        char *_rname=(char *) sqlite3_column_text(st, 2);
        NSString *_rcpname= _rname == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rname];
         NSLog(@" vitamins : %@ , %s , %s",_rcpname,(char *) sqlite3_column_text(st, 0),(char *) sqlite3_column_text(st, 1));
        txtWater.text=_rcpname;
    }

    [backGroundImageView addSubview:txtWater];
    
    
    int i;
    for(i=0;i<nsar.count;i++)
    {
        UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 40*i, 320, 40)];
        topBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
        topBar.userInteractionEnabled = YES;
        [scrollview addSubview:topBar];
        
        UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 320, 2)];
        divider.image=[UIImage imageNamed:@"divider.png"];
        divider.userInteractionEnabled = YES;
        topBar.tag=i;
        [topBar addSubview:divider];
        
        UIButton *selectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectbtn addTarget:self
                      action:@selector(selectbtnClick:)
            forControlEvents:UIControlEventTouchUpInside];
        [selectbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectbtn.tag=i;
        
        [[DataManager shared]createDB];
        sqlite3_stmt *st=[[DataManager shared] fetchData:[NSString stringWithFormat:@"select * from DailyTable where dailyDate='%@' and dailyType='%@' and activity='%@'",txtdt.text,@"Vitamin",nsar[i]]];
        [selectbtn setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
        while (sqlite3_step(st)==SQLITE_ROW)
        {
            [selectbtn setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
            
            
            char *_rname=(char *) sqlite3_column_text(st, 2);
            NSString *_rcpname= _rname == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rname];

            [ns setObject:[NSString stringWithFormat:@"%@",_rcpname] forKey:[NSString stringWithFormat:@"%@",_rcpname]];
        }
        
        
        [selectbtn setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateHighlighted];
        selectbtn.frame = CGRectMake(topBar.frame.size.width-40, 4, 35, 35);
        [topBar addSubview:selectbtn];
        
        
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(20, 6, 250, 25)];
        alphatext.text=nsar[i];
        
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
        alphatext.textAlignment=NSTextAlignmentLeft;
        alphatext.tag=0;
        
        [topBar addSubview:alphatext];
        
    }
    UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(60, i*40+20, 250, 25)];
    alphatext.text=@"Exersize";
    
    alphatext.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:18];
    alphatext.backgroundColor=[UIColor clearColor];
    alphatext.textColor=[UIColor colorWithRed:106/255.0f green:182/255.0f blue:109/255.0f alpha:1.0f] ;
    alphatext.textAlignment=NSTextAlignmentLeft;
    alphatext.tag=0;
    
    [scrollview addSubview:alphatext];
    //__________________________Exercise Yes______________________________________________
    selectbtns = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectbtns addTarget:self
                   action:@selector(excYes:)
         forControlEvents:UIControlEventTouchUpInside];
    [selectbtns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectbtns.tag=i;
    [selectbtns setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
    [selectbtns setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateHighlighted];
    selectbtns.frame = CGRectMake(140, i*40+14, 35, 35);
    [scrollview addSubview:selectbtns];
    
    //______________________________yes Label___________________________________________________
    
    UILabel *lblyes=[[UILabel alloc]initWithFrame:CGRectMake(175, i*40+20, 50, 25)];
    lblyes.text=@"Yes";
    
    lblyes.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:18];
    lblyes.backgroundColor=[UIColor clearColor];
    lblyes.textColor=[UIColor colorWithRed:63/255.0f green:63/255.0f blue:63/255.0f alpha:1.0f];
    lblyes.textAlignment=NSTextAlignmentLeft;
    lblyes.tag=0;
    
    [scrollview addSubview:lblyes];
    
    //_____________________________No button____________________________________________________
    
    notbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notbtn addTarget:self
               action:@selector(excNo:)
     forControlEvents:UIControlEventTouchUpInside];
    [notbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    notbtn.tag=i;
    [notbtn setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
    [notbtn setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateHighlighted];
    notbtn.frame = CGRectMake(210, i*40+14, 35, 35);
    [scrollview addSubview:notbtn];
    
    //______________________________No Label___________________________________________________
    
    UILabel *lblNo=[[UILabel alloc]initWithFrame:CGRectMake(250, i*40+20, 50, 25)];
    lblNo.text=@"No";
    
    lblNo.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:18];
    lblNo.backgroundColor=[UIColor clearColor];
    lblNo.textColor=[UIColor colorWithRed:63/255.0f green:63/255.0f blue:63/255.0f alpha:1.0f];
    lblNo.textAlignment=NSTextAlignmentLeft;
    lblNo.tag=0;
    
    [scrollview addSubview:lblNo];
    
    //_______________________________Exercise view______________________________________________
    exerBar = [[UIView alloc] initWithFrame:CGRectMake(0, i*40+60, 320, 70)];
    exerBar.backgroundColor = [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0f];
    exerBar.userInteractionEnabled = YES;
    
    exerBar.hidden=YES;
       [scrollview addSubview:exerBar];
    
    //_______________________________TextField Activity__________________________________________
    
    UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 250, 30)];
    nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [exerBar addSubview:nameBackGroundView];
    
    txtActivity = [[UITextField alloc] initWithFrame:CGRectMake(45, 3, 220, 25)];
    txtActivity.delegate=self;
    txtActivity.placeholder = @"Activity";
    [txtActivity setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    txtActivity.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtActivity.borderStyle = UITextBorderStyleNone;
    txtActivity.backgroundColor = [UIColor clearColor];
    [txtActivity setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtActivity.returnKeyType = UIReturnKeyNext;
    txtActivity.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [exerBar addSubview:txtActivity];
    //_______________________________TextField Duration__________________________________________
    
    UIImageView *nameBackGroundViews = [[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 250, 30)];
    nameBackGroundViews.image = [UIImage imageNamed:@"inputbox.png"];
    nameBackGroundViews.userInteractionEnabled = YES;
    [exerBar addSubview:nameBackGroundViews];
    
    txtDuration = [[UITextField alloc] initWithFrame:CGRectMake(45, 38, 220, 25)];
    txtDuration.delegate=self;
    txtDuration.placeholder = @"Duration";
    [txtDuration setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    txtDuration.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtDuration.borderStyle = UITextBorderStyleNone;
    txtDuration.backgroundColor = [UIColor clearColor];
    [txtDuration setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtDuration.returnKeyType = UIReturnKeyNext;
    txtDuration.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [exerBar addSubview:txtDuration];
    
    //================================Save Button=====================================================
    btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave addTarget:self
                action:@selector(saveClick)
      forControlEvents:UIControlEventTouchUpInside];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSave.tag=i;
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSave.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Semibold" size:15];
    [btnSave setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateNormal];
    [btnSave setBackgroundImage:[UIImage imageNamed:@"reset_password.png"] forState:UIControlStateHighlighted];
    btnSave.frame = CGRectMake(35, lblyes.frame.origin.y+50, 250, 35);
    [scrollview addSubview:btnSave];
    
    [[DataManager shared]createDB];
    sqlite3_stmt *sts=[[DataManager shared] fetchData:[NSString stringWithFormat:@"select * from DailyTable where dailyDate='%@' and dailyType='%@'",txtdt.text,@"Exercise"]];
    
    while (sqlite3_step(sts)==SQLITE_ROW)
    {
        char *_rname=(char *) sqlite3_column_text(sts, 2);
        NSString *_rcpname= _rname == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rname];
        
        NSArray *substrings = [_rcpname componentsSeparatedByString:@","];

         NSLog(@" vitamins ok: %@ , %s , %s",_rcpname,(char *) sqlite3_column_text(st, 0),(char *) sqlite3_column_text(st, 1));
        if([substrings[0] length]!=1)
        txtActivity.text=substrings[0];
         //NSLog(@"o:%d",[substrings[1] length]);
        if([substrings[1] length]!=1)
        txtDuration.text=substrings[1];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [selectbtns setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
        [notbtn setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
        float f=btnSave.frame.origin.y;
        btnSave.frame=CGRectMake(35,f+60, 250, 35);
        scrollview.contentSize=CGSizeMake(self.view.frame.size.width,f+120.f);
        [UIView commitAnimations];
        
        exerBar.hidden=NO;
        
    }
    

    
}
-(void)saveClick{
    @autoreleasepool {
        
        
        NSString *str=[[NSString alloc]init];
        [[DataManager shared]createDB];
                       [[DataManager shared]insertData:[NSString stringWithFormat:@"delete from DailyTable where dailyDate='%@'",txtdt.text]];
        for (id key in ns)
        {
            //id value = [ns objectForKey:key];
            NSString *st=[NSString stringWithFormat:@"%@",[ns objectForKey:key] ];
            str= [str stringByAppendingString:st];
            
            
            
       
            [[DataManager shared]createDB];
            [[DataManager shared] insertData:[NSString stringWithFormat:@"insert into DailyTable (dailyDate,dailyType,activity) values ('%@','%s','%@')",txtdt.text,"Vitamin",st]];
            
        }
        if([txtDuration.text length]!=0 ||[txtActivity.text length]!=0 ){
            [[DataManager shared]createDB];
            [[DataManager shared] insertData:[NSString stringWithFormat:@"insert into DailyTable (dailyDate,dailyType,activity) values ('%@','%s','%@')",txtdt.text,"Exercise",[NSString stringWithFormat:@"%@, %@",txtActivity.text,txtDuration.text]]];
            
        }
        if([txtWater.text length]!=0){
            
            [[DataManager shared]createDB];
            [[DataManager shared] insertData:[NSString stringWithFormat:@"insert into DailyTable (dailyDate,dailyType,activity) values ('%@','%s','%@')",txtdt.text,"Water",txtWater.text]];
            
        }
    }
    // [str stringByAppendingFormat:@"%@, ",nk[i]];
    
    
}
-(void)excYes:(id)Sender{
    if(exerBar.hidden){
        UIButton *b=Sender;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [b setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
        [notbtn setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
        float f=btnSave.frame.origin.y;
        btnSave.frame=CGRectMake(35,f+60, 250, 35);
        scrollview.contentSize=CGSizeMake(self.view.frame.size.width,f+120.f);
        [UIView commitAnimations];
        
        
        exerBar.hidden=NO;
    }
}
-(void)excNo:(id)Sender{
    if(!exerBar.hidden){
        UIButton *b=Sender;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [b setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
        [selectbtns setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
        
        float f=btnSave.frame.origin.y;
        btnSave.frame=CGRectMake(35,f-60, 250, 35);
        scrollview.contentSize=CGSizeMake(self.view.frame.size.width,f+120.f);
        [UIView commitAnimations];
        exerBar.hidden=YES;
    }
}
-(void)selectbtnClick:(id)Sender{
    UIButton *bt=(UIButton*)Sender;
    if ([ns objectForKey:nsar[bt.tag]]) {
        [bt setBackgroundImage:[UIImage imageNamed:@"list_check.png"] forState:UIControlStateNormal];
        [ns removeObjectForKey:nsar[bt.tag]];
    }
    else
    {
        
        
        
        [bt setBackgroundImage:[UIImage imageNamed:@"list_check_onclick.png"] forState:UIControlStateNormal];
        //[ns addObject:[NSString stringWithFormat:@"%@",nsar[bt.tag]]];
        
        [ns setObject:[NSString stringWithFormat:@"%@",nsar[bt.tag]] forKey:[NSString stringWithFormat:@"%@",nsar[bt.tag]]];
    }
    
}
- (void)tapped

{
    
    [txtActivity resignFirstResponder];
    [txtDuration resignFirstResponder];
    [txtWater resignFirstResponder];
    [txtdt resignFirstResponder];
    
    
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
//-(void)viewWillAppear:(BOOL)animated{
//
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (screenSize.height > 480.0f)
//        {
//            [txtActivity resignFirstResponder];
//            [txtDuration resignFirstResponder];
//            [txtWater resignFirstResponder];        } else
//        {
//
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(keyboardWillShow)
//                                                         name:UIKeyboardWillShowNotification
//                                                       object:nil];
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(keyboardWillHide)                                                       name:UIKeyboardWillHideNotification
//                                                       object:nil];
//            
//        }
//    }
//    
//}



@end
