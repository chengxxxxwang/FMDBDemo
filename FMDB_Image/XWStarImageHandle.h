//
//  XWStarImageHandle.h
//  FMDB_Image
//
//  Created by chenxingwang on 2016/11/7.
//  Copyright © 2016年 chenxingwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWStarModel.h"

@interface XWStarImageHandle : NSObject

@property (nonatomic ,strong) XWStarModel* imageModel;

/**
 保存数据

 @param imageModel 图片模型数据

 */
- (void)saveDataWithParams:(XWStarModel *)imageModel;

/**
 获取保存数据总条数

 @return count
 */
- (NSInteger)getCountOfSaveData;

/**
 获取保存数据图片

 @param key imageid
 @return 图片
 */
- (UIImage *)getImageDataWithKey:(NSString *)key;

/**
 根据 关键词 查询

 @param key 关键词
 */
- (void) queryDataWithKey:(NSString *)key InColumnName:(NSString *)column;



/**
 获取所有数据

 @return 数据
 */
- (NSArray *)recordList;

/**
 根据关键词删除数据

 @param key 关键词
 */
- (void) deleteDataWithKey:(NSString *)key;

/**
 移除所有数据
 */
- (void)removeAllDataInDataBase;

@end
