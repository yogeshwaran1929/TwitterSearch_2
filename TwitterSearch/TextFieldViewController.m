//
//  TextFieldViewController.m
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import "TextFieldViewController.h"
#import "ListViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController
@synthesize userDetails;
@synthesize passingLatitude,passingLongitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *markArray = [userDetails componentsSeparatedByString:@"^"];
    NSString* userNameString = [markArray objectAtIndex: 0];
    NSString* screenNameString = [markArray objectAtIndex: 1];
    NSString* userImageURL = [markArray objectAtIndex: 2];

    
    /// Static for iphone simulator
    
    passingLatitude = 13.024492;
    passingLongitude = 80.215529;
    
    
    
    /// User Location
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];

    
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headerLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    headerLabel.text = @"User Details";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
    [self.view addSubview:headerLabel];
    
    
    UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, headerLabel.frame.size.height+headerLabel.frame.origin.y+10, 80, 80)];
    [self.view addSubview:userImage];
    
    
    //// Using GCD Method load Image Asyn Mode
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",userImageURL]]];
        UIImage *img = [[UIImage alloc] init];
        img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(data.length > 0)
            {
                userImage.image =  img;
                
            }
  
        });
    });

    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(userImage.frame.size.width+userImage.frame.origin.x+10, headerLabel.frame.size.height+headerLabel.frame.origin.y+20, self.view.frame.size.width-userImage.frame.size.width-50, 30)];
    userName.text = @"Name";
    userName.textColor = [UIColor blackColor];
    userName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16];
    userName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:userName];
    
    UILabel *userNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(userImage.frame.size.width+userImage.frame.origin.x+10, userName.frame.size.height+userName.frame.origin.y-10, self.view.frame.size.width-userImage.frame.size.width-50, 40)];
    userNameLbl.text = userNameString;
    userNameLbl.numberOfLines = 40;
    userNameLbl.textColor = [UIColor blackColor];
    userNameLbl.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    userNameLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:userNameLbl];
    
    UILabel *screenName = [[UILabel alloc]initWithFrame:CGRectMake(10, userImage.frame.size.height+userImage.frame.origin.y+10, self.view.frame.size.width-userImage.frame.size.width-50, 30)];
    screenName.text = @"ScreenName";
    screenName.textColor = [UIColor blackColor];
    screenName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16];
    screenName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:screenName];
    
    UILabel *screenNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, screenName.frame.size.height+screenName.frame.origin.y-10, self.view.frame.size.width-50, 40)];
    screenNameLbl.text =screenNameString;
    screenNameLbl.numberOfLines = 40;
    screenNameLbl.textColor = [UIColor blackColor];
    screenNameLbl.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    screenNameLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:screenNameLbl];

 
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, screenNameLbl.frame.size.height+screenNameLbl.frame.origin.y+30, 200, 32)];
    searchField.delegate =self;
    searchField.tag = 100;
    searchField.layer.borderWidth = 0.5;
    searchField.layer.borderColor = [[UIColor grayColor]CGColor];
    searchField.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0f];
    searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchField.layer.cornerRadius = 3.0f;
    searchField.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16];
    searchField.placeholder = @" Search Place";
    searchField.autocorrectionType = UITextAutocapitalizationTypeNone;
    searchField.autocorrectionType =UITextAutocorrectionTypeNo;
    [self.view addSubview:searchField];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake( (self.view.frame.size.width-120)/2, searchField.frame.origin.y+searchField.frame.size.height+25,120, 30);
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor colorWithRed:31.0/255 green:155.0/255 blue:29.0/255 alpha:1]];
    searchButton.layer.cornerRadius = 2.0f;
    searchButton.layer.shadowColor = [UIColor grayColor].CGColor;
    searchButton.layer.shadowOpacity = 1.0f;
    searchButton.layer.shadowRadius = 1.0f;
    searchButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15];
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];

  
   

    
    // Do any additional setup after loading the view.
}

#pragma mark SearchAction

-(void)searchButtonAction
{
    
    NSString *locationString = [NSString stringWithFormat:@"%f,%f,3km",passingLatitude,passingLongitude];
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:100];
    
    if([searchTextField.text length] != 0)
    {
        ListViewController *listVC = [[ListViewController alloc]init];
        listVC.textfieldString = searchTextField.text;
        listVC.passLoation = locationString;
        [self.navigationController pushViewController:listVC animated:YES];
    }
    else
    {
        UIAlertView* successAlert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter Search Result" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [successAlert show];
    }

}

#pragma mark - CLLocationManager  Delegates

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
    passingLatitude = newLocation.coordinate.latitude;
    passingLongitude = newLocation.coordinate.longitude;

    [locationManager stopUpdatingLocation];
    
}

#pragma mark - TextField Delegates

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
        [self.view endEditing:YES]; // dismiss the keyboard
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
