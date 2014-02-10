//
//  DataManager.h
//  TeachersAssistant
//
//  Created by Santu Dey on 2/25/14.
//  Copyright (c) 2013 Click Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataManager : UIView
{
    
    
    UIView *m_view;
    UILabel *m_label;
    UIActivityIndicatorView *m_activity;
    UIActivityIndicatorView *spinner;
}
-(BOOL)createDB;
-(BOOL)createTabel : (const char *)str;
-(BOOL)delteData:(NSString *)insertSQL;

-(BOOL)insertData :(NSString *)insertSQL;
-(sqlite3_stmt *)fetchData:(NSString *)fetchSQL;
+(DataManager *)shared;

- (void)activityIndicatorAnimate:(NSString *)textShown view:(UIView *)selfView;
-(void)removeActivityIndicator :(UIView *)selfView;

@end
