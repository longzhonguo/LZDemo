//
//  ViewController.m
//  LZDemo
//
//  Created by Jared on 2020/10/14.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "ViewController.h"
#import <DPCPickerView/DPCPickerView.h>
//#import "DPCPickerView.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()

@property (nonatomic,strong) DPCPickerView *collegeAllPickerView; //学院选择
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.listArr = [NSMutableArray array];
    NSDictionary *dic = @{@"collegeName" : @"铂金学院",
                          @"collegeId" : @"000"};
    [self.listArr insertObject:dic atIndex:0];
    dic = @{@"collegeName" : @"设计学院",
            @"collegeId" : @"111"};
    [self.listArr insertObject:dic atIndex:1];
    dic = @{@"collegeName" : @"美术学院",
            @"collegeId" : @"222"};
    [self.listArr insertObject:dic atIndex:2];
    NSArray *arr = [NSArray arrayWithArray:self.listArr];
    self.collegeAllPickerView = [[DPCPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) type:1 ListArr:arr];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.collegeAllPickerView];
    
    [self.collegeAllPickerView setReturnTextBlock1:^(NSString * _Nonnull showText, NSString * _Nonnull cid) {
        
        if (![showText isEqualToString:@"取消"]) {
            NSLog(@"当前选中值为>>>%@", showText);
        }else{
            NSLog(@"取消了");
        }
        
        NSLog(@"当前操作>>>%@", showText);
    }];
    
    self.collegeAllPickerView.categoryID=@"222";
    [self.collegeAllPickerView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.collegeAllPickerView show];
}

@end
