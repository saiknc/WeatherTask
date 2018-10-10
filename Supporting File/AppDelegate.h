//
//  AppDelegate.h
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showAlertwithMessage:(NSString *)message wihtTitle:(NSString *)title;
- (void)showAlertForNoInternetConnection;
@end

