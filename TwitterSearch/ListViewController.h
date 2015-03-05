//
//  ListViewController.h
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager ;
}

@property(nonatomic,retain) NSString *searchDetails;
@property(nonatomic,strong)UITableView *resultTableView;
@property (nonatomic, retain) NSMutableArray *resultArray;
@property(nonatomic,strong) NSString *textfieldString,*passLoation;
@property(nonatomic,assign) float passingLatitude;
@property (nonatomic,assign) float passingLongitude;

@end
