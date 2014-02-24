//
//  RecipeDetailsViewController.h
//  idfinal
//
//  Created by Click Labs on 2/14/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
@interface RecipeDetailsViewController : UIViewController<RateViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property(nonatomic,retain) NSString *recipeid;
@property(nonatomic,retain) NSString *recipesubcategoryid;
@property (strong, nonatomic) NSArray *mealtype;
@property(nonatomic,retain) NSString *tempId;

@end
