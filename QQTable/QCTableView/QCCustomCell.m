//
//  QCCustomCell.m
//  QCTableView
//
//  Created by Husky on 8/10/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "QCCustomCell.h"

@implementation QCCustomCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageName:(NSString *) imageName
                    titleName:(NSString*)titleName status:(NSString *)status{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.iv = [[UIImageView alloc] init];
        self.iv.frame = CGRectMake(0, 0, 48, 48);
        self.iv.center = CGPointMake(40, 30);
        self.iv.image = [UIImage imageNamed:imageName];
        [self.contentView addSubview:self.iv];
        
        self.label1 = [[UILabel alloc] init];
        self.label1.frame = CGRectMake(78, (60-20)/2, 60, 20);
        self.label1.text = titleName;
        [self.contentView addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] init];
        self.label2.frame = CGRectMake(self.bounds.size.width - 10, (60-20)/2, 40, 20);   //？？X坐标疑问
        self.label2.text = status;
        self.label2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.label2];
    }
    
    return self;
}

-(void)configUI:(friendList*)model
{
    self.iv.image = [UIImage imageNamed:model.headerImage];
    self.label1.text = model.name;
    self.label2.text = model.isOnline?@"在线":@"离线";
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
