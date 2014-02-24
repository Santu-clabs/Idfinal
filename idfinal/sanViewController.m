//
//  sanViewController.m
//  idfinal
//
//  Created by Click Labs on 2/10/14.
//  Copyright (c) 2014 Click Labs. All rights reserved.
//

#import "sanViewController.h"
#import "LoginViewController.h"

@interface sanViewController ()

@end

@implementation sanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backGroundImageView.userInteractionEnabled = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:backGroundImageView];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            backGroundImageView.image = [UIImage imageNamed:@"1_splash_5_ipad.png"];
        } else
        {
            backGroundImageView.image = [UIImage imageNamed:@"1_splash_5_ipad.png"];
        }
    }
    
    [self performSelector:@selector(moveToNextScreen) withObject:nil afterDelay:0];

	// Do any additional setup after loading the view, typically from a nib.
}
-(void)moveToNextScreen{
    
    NSLog(@"%lu",(unsigned long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] length]);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] length] > 0) {
      HomeViewController *svc = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
      
        
        
    }else{
        LoginViewController *ovc = [[LoginViewController alloc] init];
       [self.navigationController pushViewController:ovc animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
