//
//  FavoritesViewController.h
//  idfinal
//
//  Created by Click Labs on 2/13/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ChangepswdViewController.h"
#import "AboutViewController.h"
#import "subview.h"

@interface FavoritesViewController : UIViewController<subviewDel,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    subview *S;
}
@property (strong, nonatomic) NSArray *mealtype;
@end
