//
//  addGrocerryViewController.h
//  idfinal
//
//  Created by Click Labs on 2/21/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addGrocerryViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate>
@property (strong, nonatomic) NSMutableArray *mealtype;
@end
