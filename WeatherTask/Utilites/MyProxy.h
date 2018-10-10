//
//  MyProxy.h
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol WebServiceDelegate <NSObject>
- (void)serviceResponse:(NSDictionary *)responseDic
         withServiceURL:(NSString *)str_service;

@end
@interface MyProxy : NSObject

@property(nonatomic, strong) id<WebServiceDelegate> delegate;


- (void)getServiceWith:(NSString *)getURL
               postDic:(NSMutableDictionary *)params;
+ (MyProxy *)sharedProxy;
- (BOOL)checkReachability;
- (void)showActivityIndicatorWithLabel:(NSString *)message;
- (void)hideActivityIndicatorInView;

@end
