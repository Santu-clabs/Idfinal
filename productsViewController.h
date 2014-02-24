//
//  productsViewController.h
//  idfinal
//
//  Created by Click Labs on 2/11/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productsViewController : UIViewController<UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    UIActionSheet *actionSheet;
}
@property(atomic,retain)NSString *query;
@property (strong, nonatomic) NSArray *mealtype;
@end
