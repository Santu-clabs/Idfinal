//
//  DataManager.m
//  TeachersAssistant
//
//  Created by Chirag Sharma on 2/25/13.
//  Copyright (c) 2013 Click Labs. All rights reserved.
//

#import "DataManager.h"
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
static DataManager *dataManager;
@implementation DataManager
{
    NSString *databasePath;
    NSMutableArray *array;
}

+(DataManager *) shared{
    if(!dataManager){
        dataManager = [[DataManager alloc] init];
        [dataManager createDB];
    }
    return dataManager;
}

- (void)activityIndicatorAnimate:(NSString *)textShown view:(UIView *)selfView
{
    
    selfView.userInteractionEnabled=NO;
    NSLog(@"animation start");
    
    m_view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    m_view.center = selfView.center ;
    
    [selfView addSubview:m_view];
    
    m_view.backgroundColor=[UIColor blackColor];
    
    m_view.alpha=0.7;
    
    m_view.layer.cornerRadius = 10;
    
    m_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 40)];
    
    m_label.font = [UIFont boldSystemFontOfSize:14];
    
    m_label.text=textShown;
    m_label.textAlignment = NSTextAlignmentCenter;
    m_label.textColor=[UIColor whiteColor];
    
    m_label.backgroundColor=[UIColor clearColor];
    
    [m_view addSubview:m_label];
    
    m_activity=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(33, 25,33, 33)];
    
    m_activity.color=[UIColor whiteColor];
    
    [m_view addSubview:m_activity];
    
    [m_activity startAnimating];
    
}

-(void)removeActivityIndicator :(UIView *)selfView

{
    NSLog(@"animation Stop");
    selfView.userInteractionEnabled=YES;
    
    [m_view removeFromSuperview];
    
    [m_label removeFromSuperview];
    
    [m_activity stopAnimating];
    
    [m_activity removeFromSuperview];
    
}

-(BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"TheBluCard.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        
    }
    
    return isSuccess;
}

-(BOOL)createTabel : (const char *)str {
    BOOL isSuccess = YES;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = str;
        if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
            != SQLITE_OK)
        {
            isSuccess = NO;
            NSLog(@"Failed to create table");
        }
        sqlite3_close(database);
        return  isSuccess;
    }
    else {
        isSuccess = NO;
        NSLog(@"Failed to open/create database");
    }
    return isSuccess;
}
- (BOOL)insertData:(NSString *)insertSQL
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (BOOL)delteData:(NSString *)deleteSQL
{
    //NSLog(@"Delete: %@",deleteSQL);
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *insert_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (sqlite3_stmt *)fetchData:(NSString *)fetchSQL
{
    //NSLog(@"%@",fetchSQL);
    array = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        const char *fetch_stmt = [fetchSQL UTF8String];
        if(sqlite3_prepare_v2(database, fetch_stmt,-1, &statement, NULL)==SQLITE_OK)
        {
            sqlite3_reset(statement);
        }
        else
        {
            
        }
    }
    return statement;
}


@end
