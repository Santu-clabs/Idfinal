//
//  addGrocerryViewController.m
//  idfinal
//
//  Created by Click Labs on 2/21/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "addGrocerryViewController.h"
#import "UINoteView.h"
#import "Reachability.h"
#import "DataManager.h"
#define kOFFSET_FOR_KEYBOARD 30
@interface addGrocerryViewController ()
{
    UIImageView *backGroundImageView;
    UINoteView *uiNoteName;
    UINoteView *uiNoteQuantity;
    UINoteView *uiNoteType;
    UIPickerView *myPickerView;
    NSArray *newDataArray;
}
@end

@implementation addGrocerryViewController

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
    topBarLabel.text = @"Add Groccery";
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

    
    uiNoteName=[[UINoteView alloc]initWithFrame:CGRectMake(20, 60, 280, 110)];
    
        uiNoteName.text=@"Name:";
    
    uiNoteName.textAlignment=NSTextAlignmentJustified;
    uiNoteName.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);

     [backGroundImageView addSubview:uiNoteName];
    
    uiNoteQuantity=[[UINoteView alloc]initWithFrame:CGRectMake(20, 180, 280, 110)];
    
    uiNoteQuantity.text=@"Quantity:";
    uiNoteQuantity.textAlignment=NSTextAlignmentJustified;
    uiNoteQuantity.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    [backGroundImageView addSubview:uiNoteQuantity];
    
    uiNoteType=[[UINoteView alloc]initWithFrame:CGRectMake(20, 300, 280, 110)];
    
    uiNoteType.text=@"Category:";
    uiNoteType.textAlignment=NSTextAlignmentJustified;
    uiNoteType.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
   
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.frame=CGRectMake(0, 300, self.view.frame.size.width, 148);
    myPickerView.delegate = self;
    myPickerView.backgroundColor=[UIColor clearColor];
    
    myPickerView.showsSelectionIndicator = YES;
    uiNoteType.inputView=myPickerView;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"popup_box.png"] drawInRect:myPickerView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    myPickerView.backgroundColor=[UIColor colorWithPatternImage:image];
    
     [backGroundImageView addSubview:uiNoteType];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    
    [backGroundImageView addGestureRecognizer:tapScroll];
    
    [self fdata];
    
    
    UIButton    *btnAddGroccery=[[UIButton alloc]initWithFrame:CGRectMake(20, 430, 280, 35)];
    
    [btnAddGroccery setBackgroundImage:[UIImage imageNamed:@"login.png"]forState:UIControlStateNormal];
    [btnAddGroccery setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"]forState:UIControlStateHighlighted];
    [btnAddGroccery setTitle:@"Add to Groccery" forState:UIControlStateNormal];
    btnAddGroccery.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:13];
    [btnAddGroccery addTarget:self
                   action:@selector(btnAddGrocceryClick)
         forControlEvents:UIControlEventTouchUpInside];
    [backGroundImageView addSubview:btnAddGroccery];

	// Do any additional setup after loading the view.
}

-(void)btnAddGrocceryClick{
    [[DataManager shared]createDB];
    for(int i=0;i<newDataArray.count;i++){
        if([[newDataArray[i] objectForKey:@"name"]  isEqual: uiNoteType.text]){
            
    if([[DataManager shared]insertData:[NSString stringWithFormat:@"insert into GroceryTable (groceryName,groceryTypeName,recipeId,groceryTypeId) values ('%@','%@','%@','%@')",[NSString stringWithFormat:@"%@ %@",uiNoteQuantity.text,uiNoteName.text],uiNoteType.text,[newDataArray[i] objectForKey:@"type_id"],[newDataArray[i] objectForKey:@"type_id"]]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Successfully Added new Groccery" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];

    }
        }
    }
}

-(void)fdata{
    _mealtype=[[NSMutableArray alloc]initWithArray:Nil];
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
            NSString *urlString = [NSString stringWithFormat:@"%@getingredienttypes", purl];
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
                    
                    for (int i=0; i<newDataArray.count; i++) {
                        NSLog(@"f  %@",[newDataArray[i] objectForKey:@"name"] );
                        [_mealtype addObject:[newDataArray[i] objectForKey:@"name"] ];
                    }
                    [uiNoteType reloadInputViews];
                    [myPickerView reloadInputViews];
                    [myPickerView reloadAllComponents];
                    
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
        
        
        
        
        
        
        //    _mealtype = @[@"BreakFast", @"Lunch",
        //                  @"Dinner",@"Others"];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    uiNoteType.text=_mealtype[row];
    // Handle the selection
    
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
    
    [uiNoteName resignFirstResponder];
    [uiNoteType resignFirstResponder];
    [uiNoteQuantity resignFirstResponder];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [uiNoteName resignFirstResponder];
            [uiNoteType resignFirstResponder];
            [uiNoteQuantity resignFirstResponder];
        } else
        {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow)
                                                         name:UIKeyboardWillShowNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide)                                                       name:UIKeyboardWillHideNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow2)
                                                         name:UIKeyboardWillChangeFrameNotification
                                                       object:nil];
         
            
            
        }
    }
    
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
-(void)keyboardWillShow2 {if (self.view.frame.origin.y >= 0)
{
    [self setViewMovedUp:YES];
}
else if (self.view.frame.origin.y < 0)
{
    [self setViewMovedUp:NO];
}
}


@end
