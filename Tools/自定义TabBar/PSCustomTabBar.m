//
//  PSCustomTabBar.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSCustomTabBar.h"
#import "PSTabBarButton.h"
#import "PS_Head1.h"

@interface PSCustomTabBar()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) PSTabBarButton *tabBarButton;

@end

@implementation PSCustomTabBar

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray arrayWithCapacity:5];
    }
    return _buttons;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame: frame]) {
    }
    return self;
}

#pragma mark &************ 添加按钮的方法
- (void)ps_addTabBarButtonItem:(UITabBarItem *)item {
    //1.添加按钮
    PSTabBarButton *tabButton=[[PSTabBarButton alloc]init];
    [self addSubview:tabButton];
    [self.buttons addObject:tabButton];
    
    tabButton.item=item;  //属性传给自定义的按钮
    [tabButton addTarget:self action:@selector(tabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.如果是第一个的话  默认选中
    if(self.buttons.count==1){
        [self tabButtonClick:tabButton];
    }
}

#pragma mark 按钮点击的方法
-(void)tabButtonClick:(PSTabBarButton*)sender
{
    //调用代理方法
    if([self.delegate respondsToSelector:@selector(ps_tabBar:didSelectedButtonFrom:to:)]){
        [self.delegate ps_tabBar:self didSelectedButtonFrom:self.tabBarButton.tag to:sender.tag];
    }
    
    self.tabBarButton.selected=NO;  //当前选中的按钮取消选中状态
    sender.selected=YES; //被点击的按钮选中
    self.tabBarButton=sender;
    
}

-(void)layoutSubviews
{
    [super subviews];
    CGFloat btnW=self.ps_width/self.buttons.count;
    CGFloat btnH=self.ps_height;
    CGFloat btnY=0;
    for(int i=0;i<self.buttons.count;i++){
        PSTabBarButton *tabButton=self.buttons[i];
        tabButton.tag=i;
        CGFloat btnX=i*btnW;
        tabButton.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
