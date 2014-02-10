//
//  HomeViewController.h
//  IDapp
//
//  Created by Click Labs on 2/5/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "settingsViewController.h"

@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
      UICollectionView  *collectionViews;
}
@end
