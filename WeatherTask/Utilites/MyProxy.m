//
//  MyProxy.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "MyProxy.h"
#import "Constants.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation MyProxy
static MyProxy *sharedInstance = nil;

+ (MyProxy *)sharedProxy {
    if (!sharedInstance) {
        sharedInstance = [[MyProxy alloc] init];
    }
    return sharedInstance;
}

#pragma mark -  Webservice Methods
- (void)getServiceWith:(NSString *)getURL
               postDic:(NSMutableDictionary *)params {
    [self showActivityIndicatorWithLabel:@"Please wait.."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [[AFHTTPRequestSerializer serializer] setTimeoutInterval:60];
    [[AFHTTPSessionManager manager]
     .requestSerializer
     setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:getURL
      parameters:params
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             [self.delegate serviceResponse:responseObject withServiceURL:getURL];
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error.localizedDescription);
             [self StatusError:error
                        oprate:operation
                    requseturl:getURL
                     parameter:params];
         }];
}
- (void)StatusError:(NSError *)error
             oprate:(NSURLSessionTask *)operation
         requseturl:(NSString *)requestUrl
          parameter:(NSMutableDictionary *)parameter {
    
    NSInteger errorCode = [error code];
    NSHTTPURLResponse *httpResponse =
    error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    NSInteger responseStatusCode = httpResponse.statusCode;
    
    NSLog(@"HTTP:%ld", (long)errorCode);
    
    if (responseStatusCode == 400) // bad url
    {
        // show alert
        [KAppDelegate showAlertwithMessage:requestUrl wihtTitle:@"BAD URL!"];
    } else if (responseStatusCode == 401) // unauthorized
    {
        
        // show alert
        
        [KAppDelegate showAlertwithMessage:@"Logged Out"
                                 wihtTitle:@"UNAUTHORIZED!"];
    } else if (responseStatusCode == 404) { // file not found
        
        [KAppDelegate showAlertwithMessage:requestUrl wihtTitle:@"FILE NOT FOUND!"];
        
        
    } else if (responseStatusCode == 500) { // HTML
        
        // show alert
        [KAppDelegate showAlertwithMessage:@"Please contact system admin"
                                 wihtTitle:@"ERROR!"];
        
    } else if (responseStatusCode == 408) // server reposed error
    {
        
        [KAppDelegate showAlertwithMessage:[error localizedDescription]
                                 wihtTitle:@"ERROR!"];
    }
    
    if (errorCode == -1009) // Internet Connection lost
    {
        
        [KAppDelegate showAlertwithMessage:[error localizedDescription]
                                 wihtTitle:@"ERROR!"];
        
    } else if (errorCode == -1001) // The request timed out
    {
        
        [KAppDelegate showAlertwithMessage:[error localizedDescription]
                                 wihtTitle:@"ERROR!"];
        
    } else if (errorCode ==
               -1004) // Problem in connecting to host (Server not found)
    {
        
        // show alert
        [KAppDelegate showAlertwithMessage:[error localizedDescription]
                                 wihtTitle:@"ERROR!"];
    }
    
    [[MyProxy sharedProxy] hideActivityIndicatorInView];
}

#pragma mark -  Activity indicator

- (void)showActivityIndicatorWithLabel:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)hideActivityIndicatorInView {
    [SVProgressHUD dismiss];
}



#pragma mark - check Reachability

- (BOOL)checkReachability {
    BOOL returnYesNo;
    Reachability *reachability = [Reachability
                                  reachabilityWithHostName:@"http://www.appleiphonecell.com/"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        returnYesNo = YES;
    } else {
        returnYesNo = NO;
    }
    return returnYesNo;
}
@end
