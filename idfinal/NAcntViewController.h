//
//  NAcntViewController.h
//  IDapp
//
//  Created by Click Labs on 2/5/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "placeholderTextView.h"
#import "NAcntViewController.h"
#import "HomeViewController.h"
#import "Reachability.h"
#import "DataManager.h"
#define kOFFSET_FOR_KEYBOARD 120
@interface NAcntViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *uNametextField;
    UITextField *uPasswdtextField;
    UITextField *cPasswdtextField;

}
@end
