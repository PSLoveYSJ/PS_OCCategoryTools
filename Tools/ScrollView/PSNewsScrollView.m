//
//  PSNewsScrollView.m
//  Window
//
//  Created by  王 on 2018/9/15.
//  Copyright © 2018  王. All rights reserved.
//

#import "PSNewsScrollView.h"

typedef NS_ENUM(NSInteger,PSScrollViewType) {
    PSScrollViewTypeTitleAndContent, // 标题和内容都有
    PSScrollViewTypeTitle, // 只有标题
    PSScrollViewTypeContent // 只有内容
};


#define ButtonHeight 44
#define LineWidth 40
#define LineColor [UIColor lightTextColor]
#define LineHeight 2
#define ButtonInterval 12
#define TitleFont [UIFont systemFontOfSize:14]
#define TitleColor  [UIColor darkGrayColor]
#define TitleSelectedColor  [UIColor redColor]
#define ButtonTag 100
#define LineTimerInterval 0.1

@interface PSNewsScrollView()<UIScrollViewDelegate>

/**
 标题滚动视图
 */
@property (nonatomic, strong) UIScrollView *titleScrollView;

/**
 内容滚动视图
 */
@property (nonatomic, strong) UIScrollView *contentScrollView;

/**
 标题数组
 */
@property (nonatomic, strong) NSMutableArray *titleArray;

/**
 标题按钮数组
 */
@property (nonatomic, strong) NSMutableArray *titleButtonArray;

/**
 内容View数组
 */
@property (nonatomic, strong) NSMutableArray *contentViewArray;


/**
 下划线
 */
@property (nonatomic, strong) UIView *bottomLineView;

/**
 最后选择的按钮
 */
@property (nonatomic, strong) UIButton *lastSelectButton;

/**
 是否隐藏内容滚动视图
 */
@property (nonatomic, assign) BOOL hiddenContentScrollView;

/**
 是否隐藏标题视图
 */
@property (nonatomic, assign) BOOL hiddenTitleScrollView;

@end

@implementation PSNewsScrollView


#pragma mark &***************** life cycle

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewArray:(NSArray *)viewArray {
    if (self = [super initWithFrame:frame]) {
        self.contentScrollCanScroll = YES;
        self.bottomLineType = PSTitleBottomLineTypeAutoWidth;
        [self addSubview:self.titleScrollView];
        [self addSubview:self.contentScrollView];
        [self initData:titleArray viewArray:viewArray];

    }
    return self;
}

/**
 初始化数据
 
 @param titleArray 标题数组
 @param viewArray View数组
 */
- (void) initData:(NSArray *) titleArray viewArray:(NSArray *) viewArray {
    
    [self.titleArray removeAllObjects];
    [self.titleButtonArray removeAllObjects];
    [self.contentViewArray removeAllObjects];
    
    [self.titleArray addObjectsFromArray:titleArray];
    [self.contentViewArray addObjectsFromArray:viewArray];
    
    if (titleArray == nil) {
        self.hiddenTitleScrollView = YES;
    } else {
        [self addTitleBtn];
        self.hiddenTitleScrollView = NO;
    }
    if (viewArray == nil) {
        self.hiddenContentScrollView = YES;
    } else {
        [self addViewBtn];
        self.hiddenContentScrollView = NO;
    }
    
}

- (void)reloadTitleArray:(NSArray *)titleArray viewArray:(NSArray *)viewArray {
    
    [self initData:titleArray viewArray:viewArray];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnHeight = 0;
    CGFloat btnY = 0;
    
    CGFloat titleHeight = 0;
    if (ButtonHeight > self.frame.size.height) {
        titleHeight = self.frame.size.height;
        btnHeight = self.bottomLineType == PSTitleBottomLineTypeNone ? self.frame.size.height  : self.frame.size.height - LineHeight;
    } else {
        if (self.bottomLineType == PSTitleBottomLineTypeNone) {
            titleHeight = ButtonHeight;
            btnHeight = ButtonHeight;
        } else if(ButtonHeight + LineHeight > self.frame.size.height) {
            titleHeight = self.frame.size.height;
            btnHeight = self.frame.size.height - LineHeight;
        } else {
            titleHeight = self.bottomLineType == PSTitleBottomLineTypeNone ? ButtonHeight  : ButtonHeight + LineHeight;
            btnHeight = self.bottomLineType == PSTitleBottomLineTypeNone ? self.frame.size.height  : self.frame.size.height - LineHeight;
        }
    }
    
    
    if (self.hiddenTitleScrollView) {
        self.titleScrollView.hidden = YES;
    } else {
        self.titleScrollView.frame = CGRectMake(0, 0, self.frame.size.width, titleHeight);
        for (int i = 0; i < self.titleArray.count; i++) {
            UIButton *button = [self.titleButtonArray objectAtIndex:i];
            NSString *titleString = [self.titleArray objectAtIndex:i];
            CGFloat btnWidth = [titleString boundingRectWithSize:CGSizeMake(MAXFLOAT, ButtonHeight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: TitleFont} context:nil].size.width;
            button.frame = CGRectMake(btnX, btnY, btnWidth + ButtonInterval * 2, btnHeight);
            btnX += button.bounds.size.width;
            if (button == self.lastSelectButton) {
                if (self.bottomLineType != PSTitleBottomLineTypeNone) {
                    if (self.bottomLineType == PSTitleBottomLineTypeFixWidth) {
                        CGFloat bottomX = self.lastSelectButton.frame.origin.x + (self.lastSelectButton.frame.size.width - LineWidth) / 2;
                        self.bottomLineView.frame = CGRectMake(bottomX, btnHeight, LineWidth, LineHeight);
                    }
                    if (self.bottomLineType == PSTitleBottomLineTypeAutoWidth) {
                        CGFloat bottomX = self.lastSelectButton.frame.origin.x + (self.lastSelectButton.frame.size.width - btnWidth) / 2;
                        self.bottomLineView.frame = CGRectMake(bottomX, btnHeight, btnWidth, LineHeight);
                    }
                }
            }
        }
        
        if (btnX < self.frame.size.width) {
            [self reloadTitleButtonFrame:btnX];
        } else {
            self.titleScrollView.contentSize = CGSizeMake(btnX, 0);
            self.titleScrollView.contentOffset = CGPointMake(0, 0);
        }
        
    }
    
    
    if (self.hiddenContentScrollView) {
        self.contentScrollView.hidden = YES;
    } else {
        self.contentScrollView.frame = CGRectMake(0, self.hiddenTitleScrollView ? 0 : titleHeight, self.frame.size.width, self.frame.size.height - (self.hiddenTitleScrollView ? 0 : titleHeight));
        for (int i = 0; i < self.contentViewArray.count; i++) {
            UIView *view = [self.contentViewArray objectAtIndex:i];
            
            view.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.contentScrollView.bounds.size.height);
        }
        
        self.contentScrollView.contentSize = CGSizeMake(self.contentViewArray.count * self.frame.size.width, 0);
        self.contentScrollView.contentOffset = CGPointMake(0, 0);
    }
}

- (void) reloadTitleButtonFrame:(CGFloat) totalWidth {
    
    for (int i = 0; i < self.titleButtonArray.count; i++) {
        CGFloat buttonx = 0;
        UIButton *button = [self.titleButtonArray objectAtIndex:i];
        if (i > 0) {
            UIButton *buttonFront = [self.titleButtonArray objectAtIndex:i - 1];
            buttonx = buttonFront.frame.size.width + buttonFront.frame.origin.x;
        }
        CGRect frame = button.frame;
        frame.size.width = ( frame.size.width / totalWidth ) * self.bounds.size.width;
        frame.origin.x = buttonx;
        button.frame = frame;
        if (button == self.lastSelectButton) {
            if (self.bottomLineType != PSTitleBottomLineTypeNone) {
                if (self.bottomLineType == PSTitleBottomLineTypeFixWidth) {
                    CGFloat bottomX = self.lastSelectButton.frame.origin.x + (self.lastSelectButton.frame.size.width - LineWidth) / 2;
                    self.bottomLineView.frame = CGRectMake(bottomX, button.frame.size.height, LineWidth, LineHeight);
                }
                if (self.bottomLineType == PSTitleBottomLineTypeAutoWidth) {
                    CGFloat btnWidth = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, ButtonHeight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: TitleFont} context:nil].size.width;
                    CGFloat bottomX = self.lastSelectButton.frame.origin.x + (self.lastSelectButton.frame.size.width - btnWidth) / 2;
                    
                    self.bottomLineView.frame = CGRectMake(bottomX, button.frame.size.height, btnWidth, LineHeight);
                }
            }
        }
    }
    
    
    self.titleScrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    self.titleScrollView.contentOffset = CGPointMake(0, 0);
}


#pragma mark &***************** delelgate datasource

// 滚动了
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

// 拖拽开始减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

// 拖拽完成之后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        int index = (int)(self.contentScrollView.contentOffset.x / self.frame.size.width);
        [self reloadButtonSelected:index needPerfomDelegate:YES];
    }
}


#pragma mark &***************** btn click method

/**
 添加标题按钮
 */
- (void) addTitleBtn {
    
    for (UIView *view in self.titleScrollView.subviews) {
        [view removeFromSuperview];
    }
    [self.titleScrollView addSubview:self.bottomLineView];
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [self.titleArray objectAtIndex:i];
        [button setTitle:[self.titleArray objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = TitleFont;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:TitleColor forState:UIControlStateNormal];
        [button setTitleColor:TitleSelectedColor forState:UIControlStateSelected];
        button.tag = ButtonTag + i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            self.lastSelectButton = button;
        }
        [self.titleButtonArray addObject:button];
        [self.titleScrollView addSubview:button];
    }
}


/**
 添加内容视图
 */
- (void) addViewBtn {
    for (UIView *view in self.contentScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.contentViewArray) {
        [self.contentScrollView addSubview:view];
    }
}

- (void) titleButtonClick:(UIButton *) button {
    NSInteger tag = button.tag - ButtonTag;
    [self reloadButtonSelected:tag needPerfomDelegate:YES];
}


/**
 重新设置按钮选中
 
 @param index 选中的按钮
 */
- (void) reloadButtonSelected:(NSInteger) index needPerfomDelegate:(BOOL) need {
    if (self.hiddenTitleScrollView) {
        [self.contentScrollView setContentOffset:CGPointMake(index * self.frame.size.width, 0)];
    } else {
        if (self.lastSelectButton != [self.titleButtonArray objectAtIndex:index]) {
            self.lastSelectButton.selected = NO;
            self.lastSelectButton = [self.titleButtonArray objectAtIndex:index];
            [self.contentScrollView setContentOffset:CGPointMake(index * self.frame.size.width, 0)];
            [UIView animateWithDuration:LineTimerInterval animations:^{
                self.lastSelectButton.selected = YES;
            }];
            
            CGFloat x = self.lastSelectButton.frame.origin.x;
            CGFloat width = self.lastSelectButton.frame.size.width;
            CGFloat currentOffsetX = self.titleScrollView.contentOffset.x;
            
            if (self.bottomLineType != PSTitleBottomLineTypeNone) {
                [self setBottomLineFrame:self.lastSelectButton];
            }
            // 在偏移量 + 视图宽度之后 需要改变偏移量
            if (x + width > self.frame.size.width + currentOffsetX) {
                CGFloat nextX = (x + width) - (self.frame.size.width + self.titleScrollView.contentOffset.x);
                [self.titleScrollView setContentOffset:CGPointMake(nextX + currentOffsetX, 0) animated:YES];
            }
            // 按钮的x 在偏移量之前 需要改变偏移量
            if (x < currentOffsetX) {
                CGFloat nextX = x - currentOffsetX;
                [self.titleScrollView setContentOffset:CGPointMake(nextX + currentOffsetX, 0) animated:YES];
            }
        }
    }
    if (need && self.delegate && [self.delegate respondsToSelector:@selector(ps_scrollView:buttonClickIndex:)]) {
        [self.delegate ps_scrollView:self buttonClickIndex:index];
    }
}

/**
 设置底部LineView frame
 
 @param tagButton 目标View
 */
- (void) setBottomLineFrame:(UIView *) tagButton {
    if (self.bottomLineType == PSTitleBottomLineTypeFixWidth) {
        CGFloat bottomX = tagButton.frame.origin.x + (tagButton.frame.size.width - LineWidth) / 2;
        [UIView animateWithDuration:LineTimerInterval animations:^{
            self.bottomLineView.frame = CGRectMake(bottomX, tagButton.frame.size.height, LineWidth, LineHeight);
        }];
    } else if (self.bottomLineType == PSTitleBottomLineTypeAutoWidth) {
        CGFloat bottomX = tagButton.frame.origin.x + (self.lastSelectButton.frame.size.width - self.lastSelectButton.titleLabel.frame.size.width) / 2;
        [UIView animateWithDuration:LineTimerInterval animations:^{
            self.bottomLineView.frame = CGRectMake(bottomX, tagButton.frame.size.height, self.lastSelectButton.titleLabel.frame.size.width, LineHeight);
        }];
    }
}

- (void)setCurrentIndex:(NSInteger)index {
    [self reloadButtonSelected:index needPerfomDelegate:NO];
}


#pragma mark &***************** setter getter

- (void)setButtomLineType:(PSTitleBottomLineType)buttomLineType {
    if (PSTitleBottomLineTypeNone == buttomLineType) {
        self.bottomLineView.hidden = YES;
    } else {
        self.bottomLineView.hidden = NO;
    }
    [self setNeedsLayout];
}

- (void)setContentScrollCanScroll:(BOOL)contentScrollCanScroll {
    self.contentScrollView.scrollEnabled = contentScrollCanScroll;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = LineColor;
    }
    return _bottomLineView;
}

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.delegate = self;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _contentScrollView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)titleButtonArray {
    if (!_titleButtonArray) {
        _titleButtonArray = [NSMutableArray array];
    }
    return _titleButtonArray;
}

- (NSMutableArray *)contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [NSMutableArray array];
    }
    return _contentViewArray;
}

@end
