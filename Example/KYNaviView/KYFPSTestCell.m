//
//  KYFPSTestCell.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/29.
//

#import "KYFPSTestCell.h"

@interface KYFPSTestCell()
@property (nonatomic, strong)UIImageView *imageView01;
@property (nonatomic, strong)UIImageView *imageView02;
@property (nonatomic, strong)UIImageView *imageView03;
@property (nonatomic, strong)UILabel *descLabel;
@end
@implementation KYFPSTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    CGFloat space = 15;
    CGFloat ivW = (self.contentView.frame.size.width - space * 3) / 3;
    CGFloat ivH = 80;
    CGFloat ivY = space;
    self.imageView01.frame = CGRectMake(space, ivY, ivW, ivH);
    self.imageView02.frame = CGRectMake(space*2+ivW, ivY, ivW, ivH);
    self.imageView03.frame = CGRectMake(space*3+ivW*2, ivY, ivW, ivH);
    [self.contentView addSubview:self.imageView01];
    [self.contentView addSubview:self.imageView02];
    [self.contentView addSubview:self.imageView03];
    
    CGFloat lbX = space;
    CGFloat lbY = space*2 + ivH;
    CGFloat lbW = self.contentView.frame.size.width - space * 2;
    CGFloat lbH = 30;
    self.descLabel.frame = CGRectMake(lbX, lbY, lbW, lbH);
    [self.contentView addSubview:self.descLabel];
    
    self.imageView01.backgroundColor = [UIColor redColor];
    self.imageView02.backgroundColor = [UIColor redColor];
    self.imageView03.backgroundColor = [UIColor redColor];
    self.descLabel.backgroundColor = [UIColor greenColor];
}

- (void)setDataModel:(KYCellModel *)model {
    self.imageView01.image = model.image01;
    self.imageView02.image = model.image02;
    self.imageView03.image = model.image03;
    self.descLabel.text = model.desc;
}

#pragma mark: - 属性
- (UIImageView *)imageView01 {
    if (!_imageView01) {
        _imageView01 = [[UIImageView alloc] init];
        _imageView01.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView01;
}
- (UIImageView *)imageView02 {
    if (!_imageView02) {
        _imageView02 = [[UIImageView alloc] init];
        _imageView02.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView02;
}
- (UIImageView *)imageView03 {
    if (!_imageView03) {
        _imageView03 = [[UIImageView alloc] init];
        _imageView03.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView03;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}
@end
