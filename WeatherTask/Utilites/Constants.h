//
//  Constants.h
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#import "AppDelegate.h"

#define IS_IPHONE5                                                             \
(([[UIScreen mainScreen] bounds].size.height - 568) ? NO : YES)

#define KAppDelegate                                                           \
((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define KbaseURL @"http://api.openweathermap.org/data/2.5/"
#define KimageURL @"http://openweathermap.org/img/w/"
#define KgetGroupData @"group"
#define KgetCityData @"forecast"
#define KcityIDs @"1277333,4321929,1264527,1269843,1275339,1275004"
#define KtempType @"metric"
#define kappID @"b951398f3eea90c789253c571c377ee8"

#endif /* Constants_h */
