//
//  AppDelegate.m
//  WeatherTask
//
//  Created by ThoughtWave on 10/10/18.
//  Copyright © 2018 Saikuamr. All rights reserved.
//

#import "AppDelegate.h"
#import "CityListViewContoller.h"

@interface AppDelegate () {
    UIImageView *objSplashImage;
    UINavigationController *mainNavigation;
}
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (self.window == nil) {
        self.window.clipsToBounds = YES;
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    objSplashImage = [[UIImageView alloc] initWithFrame:self.window.bounds];
    objSplashImage.image = [UIImage imageNamed:@"Splash"];
    objSplashImage.clipsToBounds = YES;
    [self.window addSubview:objSplashImage];
    UIColor *themeColor = [UIColor blackColor];
    [[UINavigationBar appearance] setBarTintColor:themeColor];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance]
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             NSForegroundColorAttributeName,
                             [UIFont fontWithName:@"FontNAme" size:25],
                             NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    application.statusBarHidden = YES;
    UIViewController *VC = [[UIViewController alloc] init];
    self.window.rootViewController = VC;
    [self pushToCityNamesScreen];
    return YES;
}
// Mark: Push To RootView Controller
- (void)pushToCityNamesScreen {
    CityListViewContoller *objjVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
     instantiateViewControllerWithIdentifier:@"CityListViewContoller"];
    mainNavigation =
    [[UINavigationController alloc] initWithRootViewController:objjVC];
    self.window.rootViewController = mainNavigation;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -  Global Methods

- (void)showAlertwithMessage:(NSString *)message wihtTitle:(NSString *)title {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesButton =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action){
                               // Handle your yes please button action here
                           }];
    [alert addAction:yesButton];
    
    UIViewController *viewController = [
                                        [[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    if (viewController.presentedViewController &&
        !viewController.presentedViewController.isBeingDismissed) {
        
        viewController = viewController.presentedViewController;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:alert.view
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1
                                      constant:viewController.view.frame.size.height * 2.0f];
    
    [alert.view addConstraint:constraint];
    [viewController presentViewController:alert
                                 animated:YES
                               completion:^{
                               }];
}
- (void)showAlertForNoInternetConnection {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Message"
                                message:@"Please Check your Internet Connection"
                                preferredStyle:UIAlertControllerStyleAlert];
    [alert
     addAction:
     [UIAlertAction
      actionWithTitle:@"Go to Settings"
      style:UIAlertActionStyleDefault
      handler:^(UIAlertAction *_Nonnull action) {
          [[UIApplication sharedApplication]
           openURL:
           [NSURL
            URLWithString:
            UIApplicationOpenSettingsURLString]
           options:@{}
           completionHandler:nil];
      }]];
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"OK"
                      style:UIAlertActionStyleCancel
                      handler:^(UIAlertAction *_Nonnull action){
                      }]];
    
    UIViewController *viewController = [
                                        [[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    if (viewController.presentedViewController &&
        !viewController.presentedViewController.isBeingDismissed) {
        
        viewController = viewController.presentedViewController;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:alert.view
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1
                                      constant:viewController.view.frame.size.height * 2.0f];
    
    [alert.view addConstraint:constraint];
    [viewController presentViewController:alert
                                 animated:YES
                               completion:^{
                               }];
}




@end
