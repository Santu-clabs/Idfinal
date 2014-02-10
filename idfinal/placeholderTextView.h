//
//  placeholderTextView.h
//  placeHolder
//
//  Created by Samar Mac Mini on 7/10/13.
//  Copyright (c) 2013 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface placeholderTextView : UITextView
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;
-(void)textChanged:(NSNotification*)notification;
@end
