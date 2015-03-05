//
//  TextFieldViewController.h
//  TwitterSearch
//
//  Created by Yogi on 02/03/15.
//  Copyright (c) 2015 Yogesh Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface TextFieldViewController : UIViewController<UITextFieldDelegate>
{
    
}


@property(nonatomic,readwrite) float passingLatitude;
@property (nonatomic,readwrite) float passingLongitude;

@property(nonatomic,retain) NSString *userDetails;



@end
