//
//  PSBadgeButton.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSBadgeButton.h"
#import "PS_Head1.h"


@implementation PSBadgeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage ps_resizeImage:@"tabbar_badge"] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO; // 提醒数字不能点击
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue=[badgeValue copy];  //copy值
    
    if(badgeValue && ![badgeValue isEqualToString:@"0"]){
        self.hidden=NO;
        //设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //如果大于1个数字
        if(badgeValue.length>1){
            CGSize btnSize=[badgeValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
            self.ps_width=btnSize.width+20; //宽度+10
            self.ps_height=self.currentBackgroundImage.size.height;
        }else{
            self.ps_width = self.currentBackgroundImage.size.width;
            self.ps_height = self.currentBackgroundImage.size.height;
        }
        
    }else{
        self.hidden=YES;
    }
}

@end
