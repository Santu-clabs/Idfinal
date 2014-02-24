//
//  RecipeAddViewController.m
//  idfinal
//
//  Created by Click Labs on 2/17/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "RecipeAddViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define kOFFSET_FOR_KEYBOARD 60
#import "DataManager.h"
#import "Reachability.h"
#import "placeholderTextView.h"
#import "AsyncImageView.h"


@interface RecipeAddViewController ()
{
    UIImageView *backGroundImageView;
    UIScrollView *scrollview ;
    AsyncImageView *rcpimg;
    UIView *uiviewPopup;
    UIView *uiviewPopupover;
    UITextField  *txtName;
    UITextField  *txtIngredients;
    UITextField  *txtSectioninstores;
    placeholderTextView  *txtInstruction;
     UITextField  *txtNumberofserving;
    UITextField  *txtServingSize;
    UITextField  *txtPhase;
    UIView *uiviewMealPopup;
    UIView *uiviewMealPopupover;
    UITextField *txtIngName;
    UITextField *txtIngCategory;
    UITextField *txtIngQuantity;
    UIPickerView *myPickerView;
    NSMutableString *ingredientstypeid;
    NSMutableString *ingredientstypename;
    NSArray *newDataArray;
    NSString *filename;
    int tempid;
    NSString *PATHS;
}

@end

@implementation RecipeAddViewController

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
    PATHS=[[NSString alloc]init];
    newDataArray = [[NSArray alloc] init];
    ingredientstypeid=[[NSMutableString alloc] init ] ;
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
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-46)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    
    [backGroundImageView addSubview:scrollview];
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
-(void)fetchdata{
    rcpimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    rcpimg.image=Nil;
    [scrollview addSubview:rcpimg];
    UIView *rcpImgOverlay=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    rcpImgOverlay.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [scrollview addSubview:rcpImgOverlay];
    //choose image button
    UIButton    *btnChooseImage=[[UIButton alloc]initWithFrame:CGRectMake((rcpImgOverlay.frame.size.width/2)-75,(rcpImgOverlay.frame.size.height/2)-15, 150, 30)];
    [btnChooseImage addTarget:self action:@selector(btnChooseImageClick) forControlEvents:UIControlEventTouchUpInside];
    [btnChooseImage setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"]forState:UIControlStateNormal];
     [btnChooseImage setBackgroundImage:[UIImage imageNamed:@"login.png"]forState:UIControlStateHighlighted];
    [btnChooseImage setTitle:@"Choose Image" forState:UIControlStateNormal];
    btnChooseImage.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:13];
    [rcpImgOverlay addSubview:btnChooseImage];
    
    
    
    
    uiviewPopupover=[[UIView alloc]init ];
    uiviewPopupover.hidden=YES;
    
    uiviewPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    uiviewPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    [scrollview addSubview:uiviewPopupover];
    
    
  
    
    
    UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 153, 250, 35)];
    nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:nameBackGroundView];
    
    txtName = [[UITextField alloc] initWithFrame:CGRectMake(45, 160, 220, 25)];
    txtName.delegate=self;
    txtName.placeholder = @"Recipe title";
    [txtName setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtName.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtName.borderStyle = UITextBorderStyleNone;txtName.textAlignment = NSTextAlignmentLeft;
    txtName.backgroundColor = [UIColor clearColor];
    [txtName setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtName.returnKeyType = UIReturnKeyNext;
    txtName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [scrollview addSubview:txtName];
    
    //Ingredients
    UIImageView *nameBackGroundViewIng = [[UIImageView alloc] initWithFrame:CGRectMake(35, 193, 250, 35)];
    nameBackGroundViewIng.image = [UIImage imageNamed:@"inputbox.png"];
    nameBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:nameBackGroundViewIng];
    
    txtIngredients = [[UITextField alloc] initWithFrame:CGRectMake(45, 200, 240, 25)];
    txtIngredients.delegate=self;
    txtIngredients.placeholder = @"Ingredients";
    [txtIngredients setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtIngredients.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtIngredients.borderStyle = UITextBorderStyleNone;txtName.textAlignment = NSTextAlignmentLeft;
    txtIngredients.backgroundColor = [UIColor clearColor];
    [txtIngredients setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtIngredients.returnKeyType = UIReturnKeyNext;
    txtIngredients.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    [scrollview addSubview:txtIngredients];
    
    UIButton *btningredients = [UIButton buttonWithType:UIButtonTypeCustom];
    [btningredients addTarget:self
                     action:@selector(btningredientsClick)
           forControlEvents:UIControlEventTouchUpInside];
    [btningredients setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btningredients setBackgroundImage:[UIImage imageNamed:@"plusBtn_green.png"] forState:UIControlStateNormal];
    [btningredients setBackgroundImage:[UIImage imageNamed:@"reset_password_onclick.png"] forState:UIControlStateHighlighted];
    btningredients.frame = CGRectMake(txtIngredients.frame.size.width-30, 2, 25, 25);
    [txtIngredients addSubview:btningredients];
    
    //_______________________________________Section In Stores_________________________________________
    
    UIImageView *sisBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 233, 250, 35)];
    sisBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    sisBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:sisBackGroundView];
    
    txtSectioninstores = [[UITextField alloc] initWithFrame:CGRectMake(45, 240, 220, 25)];
    txtSectioninstores.delegate=self;
    txtSectioninstores.placeholder = @"Section In stores";
    [txtSectioninstores setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtSectioninstores.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtSectioninstores.borderStyle = UITextBorderStyleNone;txtName.textAlignment = NSTextAlignmentLeft;
    txtSectioninstores.backgroundColor = [UIColor clearColor];
    [txtSectioninstores setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtSectioninstores.returnKeyType = UIReturnKeyNext;
    txtSectioninstores.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [scrollview addSubview:txtSectioninstores];

    //____________________________________Instruction___________________________________________________
    
    
    UIImageView *insBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 273, 250, 60)];
    insBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    insBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:insBackGroundView];
    
    
    txtInstruction = [[placeholderTextView alloc] initWithFrame:CGRectMake(38, 278, 220, 50)];
    txtInstruction.delegate=self;
    txtInstruction.placeholder=@"Instruction";
    txtInstruction.placeholderColor=[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6];
    txtInstruction.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    
    txtInstruction.backgroundColor = [UIColor clearColor];
    [txtInstruction setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtInstruction.returnKeyType = UIReturnKeyNext;
    txtInstruction.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    
    [scrollview addSubview:txtInstruction];
    
    //____________________________________Number of serving______________________________________________
    
    UIImageView *nosBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 339, 250, 35)];
    nosBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    nosBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:nosBackGroundView];
    
    txtNumberofserving = [[UITextField alloc] initWithFrame:CGRectMake(45, 346, 220, 25)];
    txtNumberofserving.delegate=self;
    txtNumberofserving.placeholder = @"Number of Serving";
    [txtNumberofserving setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtNumberofserving.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtNumberofserving.borderStyle = UITextBorderStyleNone;txtName.textAlignment = NSTextAlignmentLeft;
    txtNumberofserving.backgroundColor = [UIColor clearColor];
    [txtNumberofserving setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtNumberofserving.returnKeyType = UIReturnKeyNext;
    txtNumberofserving.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [scrollview addSubview:txtNumberofserving];
    
    //____________________________________Serving Size___________________________________________________
    
    UIImageView *ssBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 379, 250, 35)];
    ssBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    ssBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:ssBackGroundView];
    
    txtServingSize = [[UITextField alloc] initWithFrame:CGRectMake(45, 386, 220, 25)];
    txtServingSize.delegate=self;
    txtServingSize.placeholder = @"Serving Size";
    [txtServingSize setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtServingSize.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtServingSize.borderStyle = UITextBorderStyleNone;txtName.textAlignment = NSTextAlignmentLeft;
    txtServingSize.backgroundColor = [UIColor clearColor];
    [txtServingSize setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtServingSize.returnKeyType = UIReturnKeyNext;
    txtServingSize.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [scrollview addSubview:txtServingSize];
    //____________________________________Phases_________________________________________________________
    
    UIImageView *phaseBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 419, 250, 35)];
    phaseBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
    phaseBackGroundView.userInteractionEnabled = YES;
    [scrollview addSubview:phaseBackGroundView];
    
    txtPhase = [[UITextField alloc] initWithFrame:CGRectMake(45, 426, 220, 25)];
    txtPhase.delegate=self;
    txtPhase.placeholder = @"Phases";
    [txtPhase setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    txtPhase.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtPhase.borderStyle = UITextBorderStyleNone;txtPhase.textAlignment = NSTextAlignmentLeft;
    txtPhase.backgroundColor = [UIColor clearColor];
    [txtPhase setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:15]];
    txtPhase.returnKeyType = UIReturnKeyNext;
    txtPhase.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [scrollview addSubview:txtPhase];
    
    //__________________________________Save Recipe______________________________________________________
    
    UIButton    *btnSaveRecipe=[[UIButton alloc]initWithFrame:CGRectMake(35, 459, 250, 35)];
    
    [btnSaveRecipe setBackgroundImage:[UIImage imageNamed:@"login.png"]forState:UIControlStateNormal];
    [btnSaveRecipe setBackgroundImage:[UIImage imageNamed:@"login_onclick_ipad.png"]forState:UIControlStateHighlighted];
    [btnSaveRecipe setTitle:@"Save" forState:UIControlStateNormal];
    btnSaveRecipe.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:13];
    [scrollview addSubview:btnSaveRecipe];
    
    if(_tempsid!=NULL){
        [btnSaveRecipe addTarget:self action:@selector(btnUpdateRecipeClick) forControlEvents:UIControlEventTouchUpInside];
        [btnSaveRecipe setTitle:@"Update" forState:UIControlStateNormal];
        
        [[DataManager shared]createDB];
        NSString *queryString  = [NSString stringWithFormat:@"SELECT * FROM UserRecipeTable where recipeId='%@'",_tempsid];
        sqlite3_stmt  *statement=[[DataManager shared]fetchData:queryString];
        while (sqlite3_step(statement)==SQLITE_ROW)
        {
            char *_rname=(char *) sqlite3_column_text(statement, 1);
            NSString *_rcpname= _rname == NULL ? nil :[[ NSString alloc]initWithUTF8String:_rname];
            
            
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
            txtName.text=_rcpname;
            txtServingSize.text=_rcpSize;
            txtIngredients.text=_ringredient;
            txtInstruction.text=_rinstru;
            txtNumberofserving.text=_rcpserving;
            PATHS=_rimg;
            
            if([self Contains:@"http" on:_rimg]){
                rcpimg.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(statement, 7)]];
            }
            else{
                rcpimg.image=[UIImage imageWithContentsOfFile:_rimg];
            }
            
            [ingredientstypeid appendString:[NSString stringWithFormat:@"%s",(char *) sqlite3_column_text(statement, 5)]];
            
            
        }

    }
    else{
        [btnSaveRecipe addTarget:self action:@selector(btnSaveRecipeClick) forControlEvents:UIControlEventTouchUpInside];
    }

    
    //===================================Fix scroll view Size===========================================
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 520);


    //____________________________________Popup for Choose Imgae_________________________________________

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
    
    uiviewMealPopupover=[[UIView alloc]init ];
    
    
    uiviewMealPopupover.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    uiviewMealPopupover.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    uiviewMealPopupover.hidden=YES;
    [scrollview addSubview:uiviewMealPopupover];
    
    
    uiviewMealPopup=[[UIView alloc]init ];
    
    
    uiviewMealPopup.frame=CGRectMake(10, (self.view.frame.size.height-230)/2, 300, 195);
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"popup_box.png"] drawInRect:uiviewMealPopup.bounds];
    UIImage *images = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
   
    uiviewMealPopup.backgroundColor=[UIColor colorWithPatternImage:images];
    [uiviewMealPopupover addSubview:uiviewMealPopup];
    UIButton *btnClosePopupViews = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClosePopupViews addTarget:self
                          action:@selector(btnClosePopupViewClick)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnClosePopupViews setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateNormal];
    [btnClosePopupViews setBackgroundImage:[UIImage imageNamed:@"popup_cross.png"] forState:UIControlStateHighlighted];
    btnClosePopupViews.frame = CGRectMake(280, 10, 10, 10);
    [uiviewPopup addSubview:btnClosePopupViews];
    
    
    
    [uiviewMealPopup addSubview:btnClosePopupViews];
    
    UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(30, 28, 100, 20)];
    alphatext.text=@"Name";
    alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
    alphatext.backgroundColor=[UIColor clearColor];
    alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
    
    [uiviewMealPopup addSubview:alphatext];
    
   
    {
        UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 23, 170, 30)];
        nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
        nameBackGroundView.userInteractionEnabled = YES;
        [uiviewMealPopup addSubview:nameBackGroundView];
        
    }
    
    txtIngName = [[UITextField alloc] initWithFrame:CGRectMake(104, 25, 150, 25)];
    txtIngName.delegate=self;
    txtIngName.tag=1;
    [txtIngName setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    txtIngName.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtIngName.borderStyle = UITextBorderStyleNone;
    txtIngName.backgroundColor = [UIColor clearColor];
    [txtIngName setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10]];
    txtIngName.returnKeyType = UIReturnKeyNext;
    txtIngName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    txtIngName.text=@"";
    txtIngName.placeholder=@"Name";
    [uiviewMealPopup addSubview:txtIngName];
    {
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(30, 63, 100, 20)];
        alphatext.text=@"Category";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
        [uiviewMealPopup addSubview:alphatext];
        
        UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 63, 170, 30)];
        nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
        nameBackGroundView.userInteractionEnabled = YES;
        [uiviewMealPopup addSubview:nameBackGroundView];
        
        
    }
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.frame=CGRectMake(0, 300, 150, 148);
    myPickerView.delegate = self;
    myPickerView.backgroundColor=[UIColor clearColor];
    myPickerView.showsSelectionIndicator = YES;
    

    txtIngCategory = [[UITextField alloc] initWithFrame:CGRectMake(104, 70, 150, 25)];
    txtIngCategory.delegate=self;
    txtIngCategory.tag=1;
    [txtIngCategory setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    txtIngCategory.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtIngCategory.borderStyle = UITextBorderStyleNone;
    txtIngCategory.backgroundColor = [UIColor clearColor];
    [txtIngCategory setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10]];
    txtIngCategory.autocapitalizationType = UITextAutocapitalizationTypeWords;
    txtIngCategory.text=@"";
    txtIngCategory.placeholder=@"Category";
    //txtIngCategory.inputView=myPickerView ;
    [txtIngCategory setInputView:myPickerView];
    [uiviewMealPopup addSubview:txtIngCategory];
    txtIngCategory.returnKeyType = UIReturnKeyNext;
    
    
    
    {
        UILabel *alphatext=[[UILabel alloc]initWithFrame:CGRectMake(30, 103, 100, 20)];
        alphatext.text=@"Quantity";
        alphatext.font = [UIFont fontWithName:@"MyriadPro-Light" size:14];
        alphatext.backgroundColor=[UIColor clearColor];
        alphatext.textColor=[UIColor colorWithRed:61/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];;
        [uiviewMealPopup addSubview:alphatext];
        
        UIImageView *nameBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 103, 170, 30)];
        nameBackGroundView.image = [UIImage imageNamed:@"inputbox.png"];
        nameBackGroundView.userInteractionEnabled = YES;
        [uiviewMealPopup addSubview:nameBackGroundView];
        
    }
    
    txtIngQuantity = [[UITextField alloc] initWithFrame:CGRectMake(104, 110, 150, 25)];
    txtIngQuantity.delegate=self;
    txtIngQuantity.tag=1;
    [txtIngQuantity setValue:[UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    txtIngQuantity.textColor = [UIColor colorWithRed:16.0/255 green:137.0/255 blue:168.0/255 alpha:1];
    txtIngQuantity.borderStyle = UITextBorderStyleNone;
    txtIngQuantity.backgroundColor = [UIColor clearColor];
    [txtIngQuantity setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10]];
    txtIngQuantity.returnKeyType = UIReturnKeyNext;
    txtIngQuantity.autocapitalizationType = UITextAutocapitalizationTypeWords;
    txtIngQuantity.text=@"";
    txtIngQuantity.placeholder=@"Quantity";
    [uiviewMealPopup addSubview:txtIngQuantity];
    
    
    
    UIButton *btnAddIngredient = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddIngredient addTarget:self
                                     action:@selector(btnAddIngredientClick)
                           forControlEvents:UIControlEventTouchUpInside];
    [btnAddIngredient setTitle:@"Add Ingredients" forState:UIControlStateNormal];
    [btnAddIngredient setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnAddIngredient.titleLabel.font = [UIFont fontWithName:@"MyriadPro-Regular" size:15];
    
    
    [btnAddIngredient setBackgroundImage:[UIImage imageNamed:@"recipes_btn.png"] forState:UIControlStateNormal];
    [btnAddIngredient setBackgroundImage:[UIImage imageNamed:@"recipes_btn_onclick.png"] forState:UIControlStateHighlighted];
    btnAddIngredient.frame = CGRectMake(40, 150, 200, 30);
    [uiviewMealPopup addSubview:btnAddIngredient];

    

    
    
    
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
                    [txtIngCategory reloadInputViews];
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
    [self.navigationController popViewControllerAnimated:YES];
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
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        
        
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"/FullImages"];
            NSString *fileName = [imageRep filename];
            filename=[[NSString alloc]initWithFormat:@"%@",[imageRep filename]];
            NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            NSData *nsds=[NSData dataWithContentsOfFile:folderPath];
        }
        
        
        UIImage *uploadImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        float hfactor = uploadImage.size.width / self.view.bounds.size.width;
        
        float vfactor = uploadImage.size.height / self.view.bounds.size.height;
        
        float factor = fmax(hfactor, vfactor);
        float newWidth = uploadImage.size.width / factor;
        
        float newHeight = uploadImage.size.height / factor;
        CGSize newSize = CGSizeMake(2*newWidth, 2*newHeight);
        
        UIGraphicsBeginImageContext(newSize);
        [uploadImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        picker.delegate=nil;
        
        [picker dismissViewControllerAnimated:NO completion:nil];
        NSString *savedGroupImagePath=[[NSString alloc]init];
        NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        savedGroupImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[imageRep filename]]];
        
        NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
        
        [imageData writeToFile:savedGroupImagePath atomically:YES];
        uploadImage=nil;
        rcpimg.image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
        
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
        
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *fileName = filename;
            NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            PATHS=folderPath;
        }
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    
   
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)btnChooseImageClick{
    uiviewPopupover.hidden=NO;
}
-(void)btnClosePopupViewClick{
    uiviewPopupover.hidden=YES;
    uiviewMealPopupover.hidden=YES;
}
- (void)tapped

{
    
    [txtName resignFirstResponder];
    [txtIngCategory resignFirstResponder];
    [txtIngName resignFirstResponder];
    [txtIngQuantity resignFirstResponder];
    [txtIngredients resignFirstResponder];
    [txtInstruction resignFirstResponder];
    [txtNumberofserving resignFirstResponder];
    [txtPhase resignFirstResponder];
    [txtSectioninstores resignFirstResponder];
    [txtServingSize resignFirstResponder];
    
    
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (scrollview.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (scrollview.frame.origin.y < 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (scrollview.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
-(void)keyboardWillShow2 {if (scrollview.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (scrollview.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


-(void)keyboardWillHide {if (scrollview.frame.origin.y >= 0)
{
    [self setViewMovedUp:YES];
}
else if (scrollview.frame.origin.y < 0)
{
    [self setViewMovedUp:NO];
}
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    CGRect rect = scrollview.frame;if (movedUp)
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
    scrollview.frame = rect;
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated{
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            [txtName resignFirstResponder];
          [txtIngCategory resignFirstResponder];
            [txtIngName resignFirstResponder];
            [txtIngQuantity resignFirstResponder];
            [txtIngredients resignFirstResponder];
           // [uPasswdtextField becomeFirstResponder];
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
-(void)btningredientsClick{
    
    uiviewMealPopupover.hidden=NO;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    txtIngCategory.text=_mealtype[row];
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
-(void)btnAddIngredientClick{
    
    for(int i=0;i<newDataArray.count;i++){
        if([[newDataArray[i] objectForKey:@"name"] isEqualToString:txtIngCategory.text]){
            txtIngredients.text=[txtIngredients.text stringByAppendingFormat:@"%@, ",txtIngName.text];
            [ingredientstypeid appendString:[NSString stringWithFormat:@"%@, ",[newDataArray[i] objectForKey:@"type_id"]]];
            [ingredientstypename appendString:[NSString stringWithFormat:@"%@, ",[newDataArray[i] objectForKey:@"name"]]];
            uiviewMealPopupover.hidden=YES;

        }
    }
   }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    }
    else
    {
        
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
                NSString *urlString = [NSString stringWithFormat:@"%@adduserrecipe", purl];
                NSData *fileData = nsds;
                
                
                
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
                [body appendData:[@"Content-Disposition: form-data; name=\"recipesubcategoryid\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"4" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //username
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"recipename\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[txtName.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //age
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"servings\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[txtNumberofserving.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //weight
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"size\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[txtServingSize.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //healthgoal
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"instructions\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[txtInstruction.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //motivation
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"ingredients\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[txtIngredients.text dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //ingred
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"ingredientstypeid\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[ingredientstypeid dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                //ingred
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"status\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //ingred
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"devicetype\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                //ingred
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Disposition: form-data; name=\"tempid\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%d",tempid] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                NSString *names=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"recipefile\"; filename=\"groupImage.jpeg\"\r\n"];
                [body appendData:[names dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                NSData *nsl=UIImagePNGRepresentation(rcpimg.image);
                [body appendData:[NSData dataWithData:nsl]];
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
                        NSLog(@"json recipe %@",json);
                        
                        
                       
                        
                        
                        if ([[json objectForKey:@"error"] isEqualToString:@"Unable to update user profile"] || [[json objectForKey:@"error"] isEqualToString:@"User Image is not uploaded"] || [[json objectForKey:@"error"] isEqualToString:@"Unable to upload user image"] || [[json objectForKey:@"error"] isEqualToString:@"Some parameters missing"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[DataManager shared] removeActivityIndicator:self.view];
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Upload error" message:@"Please fill all the field!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [alert show];
                            });
                        }else if ([[json objectForKey:@"log"] isEqualToString:@"User recipe added successfully"]){
                            [[DataManager shared]createDB];
                            [[DataManager shared]insertData:[NSString stringWithFormat:@"update UserRecipeTable set recipeImage='%@' where recipeId='%d'",[json objectForKey:@"image"],tempid]];
                            
                            [[DataManager shared] removeActivityIndicator:self.view];
                            
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Recipe Update success" message:@"User recipe updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alert show];
                            
                        }else if ([[json objectForKey:@"log"] isEqualToString:@"Username already exists"]){
                            [[DataManager shared] removeActivityIndicator:self.view];
                            
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
}

-(void)btnUpdateRecipeClick{
    

    
    
    [[DataManager shared]createDB];
    if(
       [[DataManager shared]insertData:[NSString stringWithFormat:@"update UserRecipeTable SET servings='%@', recipeName='%@', size='%@', instructions='%@', recipeImage='%@', ingredientsName='%@', ingredientsId='%@',isShared='%@' WHERE recipeId='%@'",txtNumberofserving.text,txtName.text,txtServingSize.text,txtInstruction.text,PATHS,txtIngredients.text,ingredientstypeid,@"NO",_tempsid]]){
    
    //[self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"OK");
    }
}
-(void)btnSaveRecipeClick{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = filename;
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *nsds=[NSData dataWithContentsOfFile:folderPath];
    
    
    [[DataManager shared]createDB];
    [[DataManager shared]insertData:[NSString stringWithFormat:@"insert into UserRecipeTable (recipeName,servings,size,instructions,recipeImage,ingredientsName,ingredientsId,ingredientsCategory,isShared) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",txtName.text,txtNumberofserving.text,txtServingSize.text,txtInstruction.text,folderPath,txtIngredients.text,ingredientstypeid,ingredientstypename,@"YES"]];
    [[DataManager shared]createDB];
    sqlite3_stmt *stmet=[[DataManager shared ]fetchData:@"select * from UserRecipeTable "] ;
    
    while (sqlite3_step(stmet)==SQLITE_ROW) {
        {
            char *offrName=(char *) sqlite3_column_text(stmet, 0);
            NSString *offerString= offrName == NULL ? nil :[[ NSString alloc]initWithUTF8String:offrName];
            tempid=[offerString integerValue];
            
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Ask for Add"
                                                    message:@"Do you Share this Recipe ?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil   ];
    [alert show];
    
    
    
}
-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return  [StrText rangeOfString:StrSearchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?FALSE:TRUE;
}
@end
