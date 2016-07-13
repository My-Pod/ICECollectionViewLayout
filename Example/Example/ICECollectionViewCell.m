//
//  ICECollectionViewCell.m
//  Example
//
//  Created by WLY on 16/7/12.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICECollectionViewCell.h"

@implementation ICECollectionViewCell

- (UILabel *)lable{
    if (!_lable) {
        UILabel *titleLable= [[UILabel alloc] initWithFrame:self.bounds];
        titleLable.text = @"Title";
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.layer.borderColor = [[UIColor grayColor] CGColor];
        titleLable.layer.borderWidth = 1;
        titleLable.layer.cornerRadius = 3;
        titleLable.textColor = [UIColor darkTextColor];
        [self.contentView addSubview:titleLable];
        _lable = titleLable;
    }
    return _lable;
}

- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.lable.textColor = [UIColor redColor];
        NSLog(@"%@",_lable.text);
    }else{
        self.lable.textColor = [UIColor darkTextColor];
    }
    [super setSelected:selected];
}

@end
