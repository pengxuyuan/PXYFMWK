//
//  TestViewController.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/11/14.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TestViewType) {
    TestViewType1,
    TestViewType2
};

@interface TestViewController : UIViewController

@property (nonatomic, assign) TestViewType type;

@end
