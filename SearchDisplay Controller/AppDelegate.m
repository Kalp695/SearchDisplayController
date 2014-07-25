//
//  AppDelegate.m
//  rtfToPdf
//
//  Created by NLS17 on 23/07/14.
//
//

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
    
    pageSize = CGSizeMake(640, 960);
    NSString *fileName = @"Demo.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //[self generatePdfWithFilePath:pdfFileName];
    [self savePDFFile:pdfFileName];

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
    NSLog(@"height %f  width %f",myString.size.height,myString.size.width);
    NSRange myRange;
    myRange.location = 0;
    myRange.length = myString.length;
    
    
    //Calculate frame
    NSStringDrawingContext *sdctx = [[NSStringDrawingContext alloc] init];
    
    
    // fill rect so we can visualize the frame
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, renderingRect);
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)myString);
    CGSize targetSize = CGSizeMake(320, CGFLOAT_MAX);
    
    CGRect paragraphRect = [myString boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 context:nil];
    //[myString drawInRect:renderingRect];
    [myString drawWithRect:renderingRect options:NSStringDrawingUsesLineFragmentOrigin context:sdctx];
    
    

    for(int i= 1 ; i <5 ;i++){
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
     UIImage * demoImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg",i]];
    [demoImage drawInRect:CGRectMake( 0, 0, demoImage.size.width/2, demoImage.size.height/2)];
    }
    UIGraphicsEndPDFContext();
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"PDF Created" message:@"Sucessfull" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [Alert show];
}

- (void)savePDFFile:(NSString *)file_Name
{
//    NSString *homeDir = NSHomeDirectory();
//    NSString *saveDirectory = [NSString stringWithFormat: @"%@/%@", homeDir, @"Documents/"];
//    
//    
//    NSArray *fileAr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:saveDirectory error:nil];
//    NSMutableArray *textArray = [[NSMutableArray alloc] init];
//    NSInteger currentPage = 0;
//    NSInteger currentFile = 0;
//    
//    
//    for (NSString *string in fileAr) {
//        if([string hasSuffix:@"txt"]){
//            NSString *file = [NSString stringWithFormat: @"%@/%@", saveDirectory, string];
//            NSString *text =[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
//            completeString = [NSString stringWithFormat:@"%@%@", completeString, text];
//        }
//    }
    
    NSInteger currentPage = 0;
    NSInteger currentFile = 0;
    UIFont *font = [UIFont systemFontOfSize:14.0];

    CGSize stringSize = [contents_for_pdf sizeWithFont:font
                                     constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + 50.0, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    NSString *rtf_path = [[NSBundle mainBundle] pathForResource:@"Example" ofType:@"rtf"];
    contents_for_pdf = [[NSString alloc] initWithContentsOfFile:rtf_path encoding:NSUTF8StringEncoding error:nil];
    NSData *datd=[[NSData alloc]initWithContentsOfFile:rtf_path];
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithData:datd
                                                                                  options:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType,
                                                                                            NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                                       documentAttributes:nil
                                                                                    error:nil];
    NSLog(@"height %f  width %f",myString.size.height,myString.size.width);
    NSRange myRange;
    myRange.location = 0;
    myRange.length = myString.length;

    
    NSString* pdfFileName = file_Name;
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    
    CFRange currentRange = CFRangeMake(0, 0);
        BOOL done = NO;
    
    
    
        CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (CFStringRef)myString, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)myString);

       // currentPage = currentPage;
        while (!done){
            // Mark the beginning of a new page.
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
            
            // Draw a page number at the bottom of each page
            currentPage++;
           // [self drawPageNumber:currentPage];
            
            
            
            // Render the current page and update the current range to
            // point to the beginning of the next page.
            currentRange = [self renderPage:currentPage withTextRange:currentRange andFramesetter:framesetter];
            // If we're at the end of the text, exit the loop.
            if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                done = YES;
            
        }
        currentFile ++;
        CFRelease(framesetter);
        CFRelease(currentText);
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"PDF Created" message:@"Sucessfull" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [Alert show];
    
}


// Use Core Text to draw the text in a frame on the page.
- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
       andFramesetter:(CTFramesetterRef)framesetter
{
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect    frameRect = CGRectMake(72, 72, 500, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef);
    currentRange.location += currentRange.length;
    currentRange.length = 0;
    //    CFRelease(frameRef);
    
    return currentRange;
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
