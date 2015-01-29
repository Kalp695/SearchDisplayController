@interface MainCategory : NSObject
@property (strong,nonatomic)NSString *id_Cat,*title,*imgUrl;
-(MainCategory *)initWithResponceDict:(NSMutableDictionary *)dictResponce;
@end



@interface News : NSObject
@property (strong,nonatomic)NSString *id_News,*desc,*title,*date_Added;
-(News *)initWithResponceDict:(NSMutableDictionary *)dictResponce;
@end


@interface Magazine : NSObject
@property (strong,nonatomic)NSString *id_magazine,*desc,*title,*date_Issue,*fileUrl,*imgUrl;
-(Magazine *)initWithResponceDict:(NSMutableDictionary *)dictResponce;
@end
