//
//  DPCPickerView.h
//  DPCPickerView
//
//  Created by Jared on 2020/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Curriculum_Screen)(NSString *showText,NSString *cid);

@interface DPCPickerView : UIView

// 1 = 提交作业页面-学院选择
- (id)initWithFrame:(CGRect)frame type:(NSInteger )type ListArr:(NSArray *)Listarr;

@property (nonatomic,strong)NSString *categoryID; //学院ID

@property (nonatomic, strong)Curriculum_Screen returnTextBlock1;
-(void)Screen:(Curriculum_Screen)re;

-(void)show;
-(void)dism;
@end

NS_ASSUME_NONNULL_END
