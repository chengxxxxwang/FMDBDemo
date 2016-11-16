//
//  XWStarImageHandle.m
//  FMDB_Image
//
//  Created by chenxingwang on 2016/11/7.
//  Copyright © 2016年 chenxingwang. All rights reserved.
//

#import "XWStarImageHandle.h"
#import "FMDB.h"

@implementation XWStarImageHandle
static FMDatabase *_db;

+ (void)initialize{

    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"starModel"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS starModel ('id' integer PRIMARY KEY AUTOINCREMENT NOT NULL, 'imgId' VARCHAR NOT NULL, 'imageData' blob NOT NULL, 'imgUrl' VARCHAR NOT NULL , 'downloadCount' int , 'starCount' int , 'shareCount' int ,'dimensions' VARCHAR NOT NULL );"];

}

- (NSInteger)getCountOfSaveData{
    if (![_db open]) {
        NSLog(@"Could not open db");
        return 0;
    }
    NSInteger count = 0;
    FMResultSet *set = [_db executeQuery:@"select count(*) as count from starModel where type = 'imgId'"];
    while ([set next]) {
        count += 1;
    }
    NSLog(@"there is %ld data",count);
//    [_db close];
    return count;
}

- (void)saveDataWithParams:(XWStarModel *)imageModel{

    /**
     *确定 数据库是否打开
     */
    if (![_db open]) {
        NSLog(@"数据库没有打开");
    }
    /**
     *确定 是否数据已经存在
     */
    
     NSString* imgId            = imageModel.imgId;
     NSString* imgUrl           = imageModel.imgUrl;
     NSInteger downloadCount    = imageModel.downloadCount;
     NSInteger starCount        = imageModel.starCount;
     NSInteger shareCount       = imageModel.shareCount;
     UIImage*  imageData        = imageModel.imageData;
     NSString* dimensions       = imageModel.dimensions;
    
    BOOL isExist = [self isExistsDataWithModel:imageModel];
    if (!isExist) {
        
        BOOL isSuc = [_db executeUpdateWithFormat:@"INSERT INTO starModel(imgId,imageData,imgUrl,downloadCount,starCount,shareCount,dimensions) VALUES (%@,%@,%@,%ld,%ld,%ld,%@);", imgId, imageData,imgUrl,downloadCount,starCount,shareCount,dimensions];
        
        if (!isSuc) {
            
            NSLog(@"insert failed");
            
        }else{
        
            NSLog(@"insert success");
            
        }
        
    }else{
    
        NSLog(@"data is already Exist");
        return;
    }
//    [_db close];
}

- (UIImage *)getImageDataWithKey:(NSString *)key{

    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM starModel WHERE imgId = %@ ;",key];

    FMResultSet *set = [_db executeQuery:sql];
    
    NSData *statusData = [set objectForColumnName:@"imageData"];
    
    UIImage *myImage = [UIImage imageWithData:statusData];
    
    return myImage;
    
}

- (void)queryDataWithKey:(NSString *)key InColumnName:(NSString *)column{

    
    
}

- (void) deleteDataWithKey:(NSString *)key{

    /**
     *确定 数据库是否打开
     */
    if (![_db open]) {
        NSLog(@"数据库没有打开");
    }
    
    NSString * newSql = [NSString stringWithFormat:@"DELETE  FROM starModel WHERE imgId = ?"];
    
    BOOL isSuc = [_db executeUpdate:newSql,key];
    
    if (!isSuc) {
        NSLog(@"delete failed");
    }else{
    
        NSLog(@"delete success");
    }
    
}

- (void) removeAllDataInDataBase{

    /**
     *确定 数据库是否打开
     */
    if (![_db open]) {
        NSLog(@"数据库没有打开");
    }
    
    NSString * newSql = [NSString stringWithFormat:@"DELETE FROM starModel"];
    
    BOOL isSuc = [_db executeUpdate:newSql];
    
    if (!isSuc) {
        NSLog(@"delete All failed");
    }else{
        
        NSLog(@"delete All success");
    }
    
}

- (NSArray *)recordList{
    
    NSString *sql =[NSString stringWithFormat:@"select * from starModel"];
    FMResultSet *resultSet = [_db executeQuery:sql];
    
    NSMutableArray *marr = [[NSMutableArray alloc]init];
    while([resultSet next]){
        
        XWStarModel *model = [[XWStarModel alloc]init];
        
        NSData *imageData = [resultSet dataForColumn:@"imageData"];
        
        model.imgId = [resultSet stringForColumn:@"imgId"];
        model.imgUrl = [resultSet stringForColumn:@"imgUrl"];
        model.imageData = [UIImage imageWithData:imageData];
        model.downloadCount = [resultSet intForColumn:@"downloadCount"];
        model.starCount = [resultSet intForColumn:@"starCount"];
        model.shareCount = [resultSet intForColumn:@"shareCount"];
        model.dimensions = [resultSet stringForColumn:@"dimensions"];
        
        [marr addObject:model];
    }
    return marr;
}

- (BOOL)isExistsDataWithModel:(XWStarModel *)model{
    /*
     select applicationid from app where applicationid = ?
     */
    NSString *sql = @"select imgId from starModel where imgId = ?";
    //_fmdb
    //这个方法是查询
    FMResultSet *set = [_db executeQuery:sql,model.imgId];
    
    //[set next] 如果你查询到了 这个方法会返回一个真值
    
    while ([set next]) {
        
        return YES;
        
    }
    
    return NO;
}




@end
