//
//  CityListModel.h
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityListModel : NSObject

@property (strong,nonatomic) NSString *strCityID;
@property (strong,nonatomic) NSString *strCityName;
@property (strong,nonatomic) NSString *strTemp;
@property (strong,nonatomic) NSString *strTime;
@property (strong,nonatomic) NSString *strWeather;
@property (strong,nonatomic) NSString *strIcon;

-(instancetype)initWithData:(NSDictionary*)dataDic;

@end
