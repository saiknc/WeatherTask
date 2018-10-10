//
//  CityDetailsModel.h
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDetailsModel : NSObject

@property (strong,nonatomic) NSString *strTemp;
@property (strong,nonatomic) NSString *strDay;
@property (strong,nonatomic) NSString *strTempMinMax;
@property (strong,nonatomic) NSString *strIcon;

- (instancetype)initWithData:(NSDictionary*)dataDic;
@end
