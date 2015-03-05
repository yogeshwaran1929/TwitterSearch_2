//
//  LoginViewController.m
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "TextFieldViewController.h"

@interface LoginViewController ()
{
    NSString *userId;
}

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
     //// Login Button
    
    TWTRLogInButton *loginButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        
        if (session)
        {
            
            [[[Twitter sharedInstance] APIClient] loadUserWithID:session.userID completion:^(TWTRUser *user, NSError *error)
            {
                if(user)
                {
                    NSString *commonString = [NSString stringWithFormat:@"%@^%@^%@",user.name,user.screenName,user.profileImageURL];

                    // TextField ViewController
                    TextFieldViewController *textFieldVC = [[TextFieldViewController alloc]init];
                    textFieldVC.userDetails = commonString;
                    [self.navigationController pushViewController:textFieldVC animated:YES];
                }
                else
                {
                    UIAlertView* errorAlert1=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [errorAlert1 show];
                }

            }];
            
            
        }
        else
        {
            UIAlertView* errorAlert1=[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert1 show];
        }
        
    }];
    
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
