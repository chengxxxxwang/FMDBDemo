//
//  ViewController.m
//  FMDB_Image
//
//  Created by chenxingwang on 2016/11/7.
//  Copyright © 2016年 chenxingwang. All rights reserved.
//

#import "ViewController.h"
#import "XWStarImageHandle.h"
#import "XWStarModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    UIImage *testImage = [UIImage imageNamed:@"1.gif"];
    
    NSDictionary *testDict = @{
                               @"imgId":@"adsfa",
                               @"imgUrl":@"1dfas",
                               @"downloadCount":@12,
                               @"starCount":@534,
                               @"shareCount":@21,
                               @"imageData":testImage,
                               @"dimensions":@"12341asfsd"
                               };
    
    XWStarModel *myModel = [XWStarModel new];
    
    [myModel setValuesForKeysWithDictionary:testDict];
    
    XWStarImageHandle *handle = [XWStarImageHandle new];
    
    [handle saveDataWithParams:myModel];
    
    NSArray * myarr = [handle recordList];
    
    NSLog(@"arr = %@",myarr);
    
//    UIImage *myImage = [handle getImageDataWithKey:@"adsfa"];
//    
//    NSLog(@"%@",myImage);
    
    myModel = myarr[0];
    
    NSLog(@"%@",myModel.imgId);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
