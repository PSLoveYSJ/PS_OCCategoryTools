//
//  PSTabBarButton.m
//  PSOCStudy
//
//  Created by Peng on 2018/5/22.
//  Copyright © 2018年 PengShuai. All rights reserved.
//

#import "PSTabBarButton.h"
#import "PSBadgeButton.h"
#import "PS_Head1.h"

@interface PSTabBarButton ()

@property (nonatomic,weak) PSBadgeButton *badgeButton;  //提醒数字按钮

@end


@implementation PSTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:26.0 / 255 green:178.0 / 255 blue:10.0 / 255 alpha:1] forState:UIControlStateSelected];
        //2.添加提醒数字按钮
        PSBadgeButton *badge=[[PSBadgeButton alloc]init];
        //按钮自动适应
        badge.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:badge];
        self.badgeButton=badge;
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW=contentRect.size.width;  //图片的高度
    CGFloat imageH=contentRect.size.height*0.6;  //图片的高度
    return CGRectMake(0, 0, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW=contentRect.size.width; //文字的宽度
    CGFloat imageH=contentRect.size.height*0.6;  //图片的高度
    CGFloat titleH=contentRect.size.height-imageH;  //文字的高度=按钮的高度-图片的高度
    return CGRectMake(0, imageH, titleW, titleH);
}
#pragma mark &************ 设置Item
- (void)setItem:(UITabBarItem *)item {
    _item = item;
    
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    
    //设置按钮的颜色
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    
    //添加提醒数字按钮
    self.badgeButton.badgeValue=item.badgeValue;
    self.badgeButton.ps_y=-2;
    
    //iphone 6plus 手机
    CGFloat badgeX=0;
    if(PS_Width >375){
        badgeX=self.ps_width-self.badgeButton.ps_width-20;
    }else if(PS_Width>320){  //iPhone 6
        badgeX=self.ps_width-self.badgeButton.ps_width-15;
    }else{   //iphone 4-5s的宽度
        badgeX=self.ps_width-self.badgeButton.ps_width-10;
    }
    self.badgeButton.ps_x=badgeX;
}

/*
 keyPath:属性名
 object:那个对象的属性发生改变了
 change:改变的信息
 */
#pragma mark 监听item值的改变
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    //设置按钮的颜色
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //添加提醒数字按钮
    self.badgeButton.badgeValue=self.item.badgeValue;
    self.badgeButton.ps_y=0;
    
    CGFloat badgeX=0;
    if(PS_Width>375){
        badgeX=self.ps_width-self.badgeButton.ps_width-20;
    }else if(PS_Width>320){  //iPhone 6
        badgeX=self.ps_width-self.badgeButton.ps_width-15;
    }else{   //iphone 4-5s的宽度
        badgeX=self.ps_width-self.badgeButton.ps_width-10;
    }
    self.badgeButton.ps_x=badgeX;
}
-(void)dealloc
{
    //   [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}


@end
