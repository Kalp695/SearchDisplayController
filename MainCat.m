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
