 //http://www.appcoda.com/ios-programming-facebook-login-sdk/

#import "MainCategory.h"

@implementation MainCategory
@synthesize id_Cat,title,imgUrl;
-(MainCategory *)initWithResponceDict:(NSMutableDictionary *)dictResponce
{
    MainCategory *objMain=[[MainCategory alloc]init];
    objMain.id_Cat=[dictResponce valueForKey:@"iCategoryId"];
    objMain.title=[dictResponce valueForKey:@"vTitle"];
        objMain.imgUrl=[dictResponce valueForKey:@"image_url"];
    return objMain;
}
@end




@implementation News
@synthesize id_News,desc,title,date_Added;
-(News *)initWithResponceDict:(NSMutableDictionary *)dictResponce
{
    News *objMain=[[News alloc]init];
    objMain.id_News=[dictResponce valueForKey:@"iNewsId"];
    objMain.title=[dictResponce valueForKey:@"vNewsTitle"];
    objMain.desc=[dictResponce valueForKey:@"vNewsDesc"];
    objMain.date_Added=[dictResponce valueForKey:@"dAddedDate"];

    return objMain;
}
@end


@implementation Magazine
@synthesize id_magazine,desc,title,date_Issue,fileUrl,imgUrl;
-(Magazine *)initWithResponceDict:(NSMutableDictionary *)dictResponce;
{
    Magazine *objMain=[[Magazine alloc]init];
    objMain.id_magazine=[dictResponce valueForKey:@"iMagezineId"];
    objMain.title=[dictResponce valueForKey:@"vTitle"];
    objMain.desc=[dictResponce valueForKey:@"tDescription"];
    objMain.date_Issue=[dictResponce valueForKey:@"dIssueDate"];
    objMain.imgUrl=[dictResponce valueForKey:@"image_url"];
    objMain.fileUrl=[dictResponce valueForKey:@"tPages"];

    return objMain;
}
@end

+ (void)executeRequestwithServicetype:(NSString *)serviceType withPostString:(NSString *)postString withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
    
    
    NSURL *url1=[NSURL URLWithString:@"http://ncpa.coderspreview.com/webservices/GetAllSubCategory"];
    postString=[NSString stringWithFormat:@"category_id=1&latitude=21.70&longitude=72.10"];
   // NSURL *url1=[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",WEBSERVICE_URL,serviceType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                               if(data==nil){
                                   block(nil,error);
                               }else{
                                   NSLog(@"Responce : %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                                   NSMutableDictionary * innerJson = [NSJSONSerialization                                                JSONObjectWithData:data options:kNilOptions error:&error1];
                                   block(innerJson,error); // Call back the block passed into your method
                               }
                           }];
    

 
 /*   NSError *error = Nil;
   NSData *requestData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
     NSString *str=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"json body: %@",str);
     NSData* responseData = nil;
    NSURL *url1=[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",WEBSERVICE_URL,serviceType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    responseData = [NSMutableData data] ;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url1];
    NSString *bodydata=[NSString stringWithFormat:@"json=%@",str];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
        [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *error1;
                             if(data==nil){
                                   block(nil,error);
                               }else{
                               NSLog(@"Responce : %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                               NSMutableDictionary * innerJson = [NSJSONSerialization                                                JSONObjectWithData:data options:kNilOptions error:&error1];
                               block(innerJson,error); // Call back the block passed into your method
                               }
}];
*/
}
