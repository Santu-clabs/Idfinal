//
//  RecipeAddViewController.h
//  idfinal
//
//  Created by Click Labs on 2/17/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeAddViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *mealtype;
@property (strong,nonatomic) NSString *tempsid;
@end
