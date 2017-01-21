//
//  QCCustomCell.h
//  QCTableView
//
//  Created by Husky on 8/10/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "friendList.h"

@interface QCCustomCell : UITableViewCell

@property (nonatomic, strong)UIImageView *iv;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageName:(NSString *) imageName
                    titleName:(NSString*)titleName status:(NSString *)status;

-(void)configUI:(friendList*)model;

@end
