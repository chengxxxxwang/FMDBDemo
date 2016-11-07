//
//  XWStarModel.h
//  FMDB_Image
//
//  Created by chenxingwang on 2016/11/7.
//  Copyright © 2016年 chenxingwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XWStarModel : NSObject

@property (nonatomic ,strong) NSString* imgId;
@property (nonatomic ,strong) NSString* imgUrl;
@property (nonatomic ,assign) NSInteger downloadCount;
@property (nonatomic ,assign) NSInteger starCount;
@property (nonatomic ,assign) NSInteger shareCount;
@property (nonatomic ,strong) UIImage*  imageData;
@property (nonatomic ,strong) NSString* dimensions;

@end
