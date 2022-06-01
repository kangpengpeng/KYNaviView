//
//  KYNavigationView.m
//  MobileBank
//
//  Created by 康鹏鹏 on 2021/6/9.
//

#import "KYNavigationView.h"
#import "KYNaviBackButton.h"
#import "KYNaviTool.h"


/// 默认背景色
#define NAVI_BG_COLOR           [UIColor whiteColor]
/// 默认标题颜色
#define NAVI_TITLE_COLOR        [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
/// 默认分割线颜色
#define NAVI_BOTTOM_LINE_COLOR  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
/// 默认返回按钮颜色
#define NAVI_BACK_COLOR         [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1]

#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

@interface KYNavigationView()

/// 返回按钮
@property (nonatomic, strong)KYNaviBackButton *backBtn;
/// 导航栏标题
@property (nonatomic, strong)UILabel *titleLabel;

/// 拿到控制器引用
@property (nonatomic, weak)UIViewController *controller;
/// 导航栏下方分割线
@property (nonatomic, strong)UIView *bottomLine;

/// 背景图片
@property (nonatomic, strong)UIImageView *backgroundImageView;

/// 外部添加的右侧自定义按钮
@property (nonatomic, strong)NSMutableArray *rightItemArr;
/// 外部自定义按钮容器
@property (nonatomic, strong)UIView *rightItemsContent;
@end

@implementation KYNavigationView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:NAVI_BG_COLOR];
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 如果 push 之前设置了 controller 右侧按钮，会导致坐标不准确
    // 所以，视图开始布局的时候，排版右侧自定义按钮
    [self composingRightItems:self.rightItemArr];
}

- (void)setupSubviews {
    CGFloat btnWidth = 120;
    CGFloat naviBarHeight = [KYNaviTool getNavigationBarHeight];
    CGFloat statusBarHeight = [KYNaviTool getStatusBarHeight];
    // 返回按钮
    self.backBtn.frame = CGRectMake(0, statusBarHeight, btnWidth, naviBarHeight);
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backBtn];
    [self bringSubviewToFront:self.backBtn];
    // 标题
    self.titleLabel.frame = CGRectMake(btnWidth, statusBarHeight, SCREEN_WIDTH-btnWidth*2, naviBarHeight);
    [self addSubview:self.titleLabel];
    // 分割线
    self.bottomLine.frame = CGRectMake(0, naviBarHeight+statusBarHeight-1, SCREEN_WIDTH, 1);
    [self addSubview:self.bottomLine];
}


#pragma mark: - KYNavigationViewProtocol

/// 将导航栏添加到指定控制器
/// @param controller 自定义导航栏所在控制器
- (void)addToController:(UIViewController *)controller {
    self.controller = controller;
    [controller.view addSubview:self];
}
/// 给返回按钮添加方法
/// @param target 目标实例
/// @param selector 方法名
- (void)gobackBtnAddTarget:(id)target action:(SEL)selector {
    [self.backBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}
/// 设置背景图片，默认 UIViewContentModeScaleToFill 拉伸铺满
/// @param image 图片对象
- (void)setBackgroundImage:(UIImage *)image {
    if (image == nil) return;
    [self setBackgroundImage:image contentMode:UIViewContentModeScaleToFill];
}
/// 设置背景图片
/// @param image 图片对象
/// @param contentMode 图片填充方式
- (void)setBackgroundImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    if (image == nil) return;
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView.image = image;
    self.backgroundImageView.contentMode = contentMode;
    self.backgroundImageView.frame = self.bounds;
    [self addSubview:self.backgroundImageView];
    [self sendSubviewToBack:self.backgroundImageView];
}
/// 设置标题
/// @param title 导航栏标题
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
/// 是否隐藏导航栏底部分割线
/// @param hidden 默认显示
- (void)hiddenSeparatorLine:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}
/// 设置导航栏分割线颜色
/// @param color 颜色，默认 #F0F0F0
- (void)setSeparatorLineColor:(UIColor *)color {
    self.bottomLine.backgroundColor = color;
}
/// 设置返回按钮图片
/// @param image 图片
- (void)setBackBtnImage:(UIImage *)image {
    [self setBackBtnImage:image forState:UIControlStateNormal];
}
/// 设置返回按钮图片
/// @param image 图片
/// @param state 按钮状态
- (void)setBackBtnImage:(UIImage *)image forState:(UIControlState)state {
    [self.backBtn setImage:image forState:state];
}
- (void)setBackBtnBackgroundImage:(UIImage *)image {
    [self setBackBtnBackgroundImage:image forState:UIControlStateNormal];
}
- (void)setBackBtnBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.backBtn setBackgroundImage:image forState:state];
}
- (void)setBackBtnTitle:(NSString *)title {
    [self.backBtn setTitle:title forState:UIControlStateNormal];
}
/// 设置返回按钮标题和颜色
/// @param title 提示内容
/// @param color 文本颜色
- (void)setBackBtnTitle:(NSString *)title color:(UIColor *)color {
    [self.backBtn setTitle:title forState:UIControlStateNormal];
    [self.backBtn setTitleColor:color forState:UIControlStateNormal];
}

- (void)hiddenBackBtn:(BOOL)hidden {
    [self.backBtn setHidden:hidden];
}

#pragma mark: - 添加右侧自定义按钮
/// 添加右侧自定义按钮
/// @param item 自定义View
- (void)addRightItem:(UIView *)item {
    if (item == nil) return;
    [self.rightItemArr addObject:item];
    //[self composingRightItems:self.rightItemArr];
}

/// 添加右侧自定义按钮
/// @param items 自定义View数组
- (void)addRightItems:(NSArray<UIView *> *)items {
    [self.rightItemArr removeAllObjects];
    [self.rightItemArr addObjectsFromArray:items];
    //[self composingRightItems:self.rightItemArr];
}
/// 排版右侧自定义视图集合
- (void)composingRightItems:(NSArray<UIView *> *)items {
    // 为了不触发属性的懒加载，使用 实例变量判断
    if (!_rightItemsContent) {
        CGFloat titleLabelRightX = CGRectGetMaxX(self.titleLabel.frame);
        CGFloat contentY = [KYNaviTool getStatusBarHeight];
        CGFloat contentH = CGRectGetHeight(self.frame) - contentY;
        self.rightItemsContent.frame = CGRectMake(titleLabelRightX, contentY, SCREEN_WIDTH-titleLabelRightX, contentH);
        [self addSubview:self.rightItemsContent];
    }
    for (UIView *item in self.rightItemsContent.subviews) {
        [item removeFromSuperview];
    }
    CGFloat contentW = CGRectGetWidth(self.rightItemsContent.frame);
    NSLog(@"contentW ===> %f", contentW);
    NSLog(@"navi.y ===> %f", self.frame.origin.y);

    CGFloat rightSpace = 10;
    CGFloat eleSpace = 10;
    CGFloat eleH = 30;
    CGFloat eleW = (contentW - rightSpace) / self.rightItemArr.count;
    eleW = MIN(eleH, eleW);
    CGFloat eleY = (CGRectGetHeight(self.frame) - [KYNaviTool getStatusBarHeight] - eleH) / 2.0;
    
    NSLog(@"contentW ===> %f", contentW);
    NSLog(@"eleW ===> %f", eleW);
    // 倒序遍历，从右向左排版显示
    [self.rightItemArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *element = (UIView *)obj;
        CGFloat eleX = contentW - rightSpace - ((idx+1) * eleW) - (idx * eleSpace);
        element.frame = CGRectMake(eleX, eleY, eleW, eleH);
        element.backgroundColor = [UIColor clearColor];
        [self.rightItemsContent addSubview:element];
    }];
}


#pragma mark: - 属性
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = NAVI_TITLE_COLOR;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _titleLabel;
}

- (KYNaviBackButton *)backBtn {
    if (!_backBtn) {
        NSBundle *currBundle = [NSBundle bundleForClass:self.class];
        NSString *imagePath = [currBundle pathForResource:@"navi_back_black@2x.png" ofType:nil inDirectory:@"KYNaviView.bundle"];
        UIImage *backImg = [UIImage imageWithContentsOfFile:imagePath];
        _backBtn = [KYNaviBackButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:backImg forState:UIControlStateNormal];
        [_backBtn setTitleColor:NAVI_BACK_COLOR forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = NAVI_BOTTOM_LINE_COLOR;
    }
    return _bottomLine;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        // 拉伸铺满
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}
- (NSMutableArray *)rightItemArr {
    if (!_rightItemArr) {
        _rightItemArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _rightItemArr;
}
- (UIView *)rightItemsContent {
    if (!_rightItemsContent) {
        _rightItemsContent = [[UIView alloc] init];
        _rightItemsContent.backgroundColor = [UIColor clearColor];
    }
    return _rightItemsContent;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



@end
