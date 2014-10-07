+ (void)executeParentRequestwithServicetype:(NSString *)serviceType withDictionary:(NSMutableDictionary *)dict  withBlock:(void (^)(NSMutableDictionary *dictresponce,NSError *error))block {
    
    NSError *error = Nil;
    NSMutableDictionary *requestdict=[[NSMutableDictionary alloc]init];
    [requestdict setObject:serviceType forKey:@"name"];
    [requestdict setObject:dict forKey:@"body"];
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestdict options:kNilOptions error:&error];
    NSString *str=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"json body: %@",str);
    NSData* responseData = nil;
    NSURL *url1=[NSURL URLWithString:[WEBSERVICE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
                                   NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                      JSONObjectWithData:data options:kNilOptions error:&error1];
                                   block(innerJson,error); // Call back the block passed into your method
                               }
                           }];
    
}

