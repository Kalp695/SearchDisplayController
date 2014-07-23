//
//  AppDelegate.h
//  SearchDisplay Controller
//
//  Created by NLS17 on 18/07/14.
//  Copyright (c) 2014 Kalpit Gajera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end


//pdf create from rtf


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
