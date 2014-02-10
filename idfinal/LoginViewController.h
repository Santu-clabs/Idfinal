//
//  LoginViewController.h
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
#import "fpasswordViewController.h"
#import "DataManager.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *uNametextField;
    UITextField *uPasswdtextField;
}
@end
