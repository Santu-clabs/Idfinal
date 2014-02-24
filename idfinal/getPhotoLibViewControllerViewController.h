//
//  getPhotoLibViewControllerViewController.h
//  idfinal
//
//  Created by Click Labs on 2/18/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>
@interface getPhotoLibViewControllerViewController : UIViewController
{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}

-(void)allPhotosCollected:(NSArray*)imgArray;

@end
