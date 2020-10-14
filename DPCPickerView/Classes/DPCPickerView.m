//
//  DPCPickerView.m
//  DPCPickerView
//
//  Created by Jared on 2020/10/14.
//

#import "DPCPickerView.h"
#import "UIViewExt.h"

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define  LL_TabbarSafeBottomMargin         (LL_iPhoneX ? 34.f : 0.f)
#define  LL_iPhoneX   (IPHONE_X)
//iphonex及以上 所有设备宏
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

@interface DPCPickerView () <UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
}

////UI
@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *categoryname; //学院名称

@property (nonatomic, strong) UIView *bgview;

@property (nonatomic, strong) UIPickerView *pickerViiew; //内容

@end

@implementation DPCPickerView

- (id)initWithFrame:(CGRect)frame type:(NSInteger)type ListArr:(NSArray *)Listarr {
    self = [super initWithFrame:frame];

    if (self) {
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(top_dism)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap1];

        self.backgroundColor = UIColorFromRGBA(0x000000, 0.4);
        self.type = type;
        self.listArr = [NSMutableArray arrayWithArray:Listarr];
        self.bgview = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 359 + LL_TabbarSafeBottomMargin + 10)];
        self.bgview.layer.masksToBounds = YES;
        self.bgview.layer.cornerRadius = 10;
        self.bgview.backgroundColor = UIColorFromRGBA(0xffffff, 1);
        [self addSubview:self.bgview];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesture)];
        self.userInteractionEnabled = YES;
        [self.bgview addGestureRecognizer:tap];
        
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(20, 100, ScreenWidth-40, 44);
////        [btn setImage:[UIImage imageNamed:@"学院选择确定"] forState:UIControlStateNormal];
//
//        //到指定目录
//        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
//        bundleURL = [bundleURL URLByAppendingPathComponent:@"DPCPickerView"];
//        bundleURL = [bundleURL URLByAppendingPathExtension:@"framework"];
//        if (bundleURL) {
//            NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
//            NSInteger scale = [[UIScreen mainScreen] scale];
//            NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", @"学院选择确定",scale];
////            imgView.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]];
//            [btn setImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]] forState:UIControlStateNormal];
//        }
//
////        NSString *imgName = [NSString stringWithFormat:@"%@/%@", @"DPCPickerViewImg.bundle",@"学院选择确定"];
////        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//
//    //    btn.backgroundColor = UIColor.lightGrayColor;
////        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"DPCPickerViewImg" withExtension:@"bundle"];
////        if (bundleURL) {
////            NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
////            NSInteger scale = [[UIScreen mainScreen] scale];
////            NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", @"学院选择确定",scale];
////            UIImage *image = [UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]];
////            [btn setImage:image forState:UIControlStateNormal];
////        }
//        [self addSubview:btn];
//
//        UILabel *but_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 44)];
//        but_lable.textAlignment = NSTextAlignmentCenter;
//        but_lable.textColor = UIColor.whiteColor;
//        but_lable.text = @"确定";
//        but_lable.userInteractionEnabled = NO;
//        but_lable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
//        [btn addSubview:but_lable];

        if (self.type == 1) {
            [self set_all_category_view];
        }
    }

    return self;
}

- (void)set_all_category_view {
    NSDictionary *dic = @{@"collegeName" : @"全部学院",
                          @"collegeId" : @""};
    [self.listArr insertObject:dic atIndex:0];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.bgview addSubview:topView];

    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 75, 25)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = UIColorFromRGBA(0x18252C, 1);
    lable.text = @"选择学院";
    lable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [topView addSubview:lable];

    UIButton *q_bur = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 60, 8, 60, 40)];
    q_bur.backgroundColor = [UIColor whiteColor];
    q_bur.tag = 201;
    [q_bur setTitle:@"取消" forState:UIControlStateNormal];
    [q_bur addTarget:self action:@selector(but_top:) forControlEvents:UIControlEventTouchUpInside];
    [q_bur setTitleColor:UIColorFromRGBA(0x969696, 1) forState:UIControlStateNormal];
    q_bur.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [topView addSubview:q_bur];

    UIButton *dism_bur = [[UIButton alloc] initWithFrame:CGRectMake(20, self.bgview.height - 44 - LL_TabbarSafeBottomMargin - 20, ScreenWidth - 40, 44)];
    dism_bur.adjustsImageWhenDisabled = NO;
    dism_bur.adjustsImageWhenHighlighted = NO;
    dism_bur.tag = 202;
    //到指定目录
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    bundleURL = [bundleURL URLByAppendingPathComponent:@"DPCPickerView"];
    bundleURL = [bundleURL URLByAppendingPathExtension:@"framework"];
    if (bundleURL) {
        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
        NSInteger scale = [[UIScreen mainScreen] scale];
        NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", @"学院选择确定",scale];
        [dism_bur setImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]] forState:UIControlStateNormal];
    }
    [dism_bur addTarget:self action:@selector(but_top:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgview addSubview:dism_bur];

    UILabel *but_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dism_bur.width, 44)];
    but_lable.textAlignment = NSTextAlignmentCenter;
    but_lable.textColor = UIColorFromRGBA(0xffffff, 1);
    but_lable.text = @"确定";
    but_lable.userInteractionEnabled = NO;
    but_lable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [dism_bur addSubview:but_lable];

    self.pickerViiew = [[UIPickerView alloc] initWithFrame:CGRectMake(16, 48, ScreenWidth - 32, 257)];
    self.pickerViiew.delegate = self;
    self.pickerViiew.dataSource = self;
    [self.bgview addSubview:self.pickerViiew];
}
- (void)top_dism { //点击黑色背景取消

    [self dism];
    if (self.returnTextBlock1 != nil) {
        self.returnTextBlock1(@"取消", @"");
    }
}

- (void)but_top:(UIButton *)but {
    [self dism];

    if (but.tag == 201) {
        if (self.returnTextBlock1 != nil) {
            self.returnTextBlock1(@"取消", @"");
        }
    } else {
        if ([self.categoryname isEqualToString:@"全部学院"]) {
            self.categoryID = @"";
        }
        self.categoryname = [self.categoryname stringByReplacingOccurrencesOfString:@"学院" withString:@""];
        if (self.returnTextBlock1 != nil) {
            self.returnTextBlock1(self.categoryname, self.categoryID);
        }
    }
}

- (void)dism {
    [UIView animateWithDuration:0.3
        animations:^{
            self.bgview.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 359 + LL_TabbarSafeBottomMargin + 10);
        }
        completion:^(BOOL finished) {
            self.hidden = YES;
        }];
}

- (void)TapGesture {
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.bgview.frame = CGRectMake(0, ScreenHeight - 359 - LL_TabbarSafeBottomMargin, ScreenWidth, 359 + LL_TabbarSafeBottomMargin + 10);
                     }
                     completion:^(BOOL finished){

                     }];

    if (self.categoryID.length > 0 && ![self.categoryID isEqualToString:@"<null>"]) {
        [self set_sele:self.categoryID];
    }
}
- (void)Screen:(Curriculum_Screen)re {
    self.returnTextBlock1 = re;
}

#pragma mark - UIPickerVIew的代理方法
//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSLog(@"%ld", component);

    /*重新定义row 的UILabel*/
    UILabel *pickerLabel = (UILabel *)view;

    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor magentaColor];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.textColor = UIColorFromRGBA(0x969696, 1);
        pickerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    }
    pickerLabel.text = [self pickerView:pickerView
                            titleForRow:row
                           forComponent:component];
    //当前选中的颜色
    UILabel *selLb = (UILabel *)[pickerView viewForRow:row forComponent:0];
    if (selLb) {
        selLb.textColor = UIColorFromRGBA(0x0CB65B, 1);
        selLb.adjustsFontSizeToFitWidth = YES;
        selLb.textAlignment = NSTextAlignmentCenter;
        selLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    }

    for (UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = UIColorFromRGBA(0xF0F0F0, 1);
        }
    }

    return pickerLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSLog(@"%ld======%ld", row, self.listArr.count);
    if (self.listArr.count > 0 && row < self.listArr.count) {
        NSDictionary *dic = self.listArr[row];
        self.categoryname = [dic objectForKey:@"collegeName"];
        self.categoryID = [dic objectForKey:@"collegeId"];
        return self.categoryname;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%ld======%ld", row, self.listArr.count);
    if (self.listArr.count > 0 && row < self.listArr.count) {
        NSDictionary *dic = self.listArr[row];
        self.categoryname = [dic objectForKey:@"collegeName"];
        self.categoryID = [dic objectForKey:@"collegeId"];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.listArr.count;
}

- (void)set_sele:(NSString *)cosid {
    if (self.listArr.count > 0) {
        for (int i = 0; i < self.listArr.count; i++) {
            NSDictionary *dic = self.listArr[i];
            NSString *ls_collegeId = [dic objectForKey:@"collegeId"];
            if ([cosid isEqualToString:ls_collegeId]) {
                [self.pickerViiew selectRow:i inComponent:0 animated:YES];
                [self pickerView:self.pickerViiew didSelectRow:i inComponent:0];
                break;
            }
        }
    }
}

@end
