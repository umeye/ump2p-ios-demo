//
//  UMNavigationView.m
//  UMViewUtils
//
//  Created by fred on 2019/3/6.
//

#import "UMNavigationView.h"
#import <Masonry/Masonry.h>

@implementation UMNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewForView];
    }
    return self;
}

#pragma make -
- (void)createViewForView{
    [self addSubview:self.titleLable];
    [self addSubview:self.leftButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints{
    [self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(5);
    }];
    [super updateConstraints];
}

#pragma make -

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont boldSystemFontOfSize:16];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UMButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UMButton alloc] init];
        _leftButton.imagePosition = CustomizeBtnImagePositionLeft;
        [_leftButton setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
@end
