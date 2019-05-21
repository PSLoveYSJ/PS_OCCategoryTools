//
//  PSNewsScrollView.h
//  Window
//
//  Created by  王 on 2018/9/15.
//  Copyright © 2018  王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSNewsScrollView;

typedef NS_ENUM(NSInteger, PSTitleBottomLineType) {
    PSTitleBottomLineTypeNone, // 没有下划线
    PSTitleBottomLineTypeFixWidth, // 固定宽度
    PSTitleBottomLineTypeAutoWidth // 根据按钮标题自动适应
} ;

@protocol PSNewsScrollViewDelegate<NSObject>


/**
 选中第几个了

 @param ps_scrollView scrollView
 @param index index
 */
- (void) ps_scrollView:(PSNewsScrollView *) ps_scrollView buttonClickIndex:(NSInteger) index;


@end



@interface PSNewsScrollView : UIView


/**
 内容View是否允许滚动 解决ScrollView滚动冲突
 */
@property (nonatomic, assign) BOOL contentScrollCanScroll;

@property (nonatomic, weak) id<PSNewsScrollViewDelegate> delegate;


/**
 设置当前选中第几个
 */
- (void) setCurrentIndex:(NSInteger) index;

/**
 更新数据

 @param titleArray 标题数组
 @param viewArray 视图数组
 */
- (void) reloadTitleArray:(NSArray *) titleArray viewArray:(NSArray *) viewArray;

/**
 初始化新闻标题

 @param frame frame
 @param titleArray titleArray
 @param viewArray viewArray
 @return scrollView
 */
- (instancetype) initWithFrame:(CGRect) frame titleArray:(NSArray *) titleArray viewArray:(NSArray *) viewArray NS_DESIGNATED_INITIALIZER;

/**
 底部按钮View
 */
@property (nonatomic, assign) PSTitleBottomLineType bottomLineType;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
