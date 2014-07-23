//
//  AppDelegate.m
//  rtfToPdf
//
//  Created by NLS17 on 23/07/14.
//
//


//
//  AppDelegate.h
//  rtfToPdf
//
//  Created by NLS17 on 23/07/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CGSize pageSize;
    NSString *pdfFileName;
    NSString *contents_for_pdf;
}

@property (strong, nonatomic) UIWindow *window;
- (void)generatePdfWithFilePath:(NSString *)thefilePath;

@end






#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *rtf_path = [[NSBundle mainBundle] pathForResource:@"Example" ofType:@"rtf"];
    contents_for_pdf = [[NSString alloc] initWithContentsOfFile:rtf_path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",contents_for_pdf);
    contents_for_pdf = [contents_for_pdf stringByReplacingOccurrencesOfString:@"I am new to StackOverflow" withString:@"I regularly visit StackOverflow"];
    
    pageSize = CGSizeMake(612, 792);
    NSString *fileName = @"Demo.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName];
    return YES;
}
- (void) generatePdfWithFilePath: (NSString *)thefilePath
{
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    //Start a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
    
    //Draw text fo our header.
    
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize stringSize = [contents_for_pdf sizeWithFont:font
                                     constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                         lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + 50.0, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    NSString *rtf_path = [[NSBundle mainBundle] pathForResource:@"Example" ofType:@"rtf"];
    contents_for_pdf = [[NSString alloc] initWithContentsOfFile:rtf_path encoding:NSUTF8StringEncoding error:nil];
    NSData *datd=[[NSData alloc]initWithContentsOfFile:rtf_path];
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithData:datd
                                                                                  options:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType,
                                                                                            NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                                       documentAttributes:nil
                                                                                    error:nil];
    NSRange myRange;
    myRange.location = 0;
    myRange.length = myString.length;
    
    
    //Calculate frame
    NSStringDrawingContext *sdctx = [[NSStringDrawingContext alloc] init];
    
    
    // fill rect so we can visualize the frame
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, renderingRect);
    
    //[myString drawInRect:renderingRect];
    [myString drawWithRect:renderingRect options:NSStringDrawingUsesLineFragmentOrigin context:sdctx];
    
    
    
   
    
    UIGraphicsEndPDFContext();
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"PDF Created" message:@"Sucessfull" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [Alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
