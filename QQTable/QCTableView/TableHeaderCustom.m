//
//  TableHeaderCustom.m
//  QQTable
//
//  Created by Husky on 8/12/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "TableHeaderCustom.h"

@implementation TableHeaderCustom

-(instancetype) initWithFrame:(CGRect)frame titles:(NSString*) title numOfOnline:(NSInteger)numOfOnline numofTotal:(NSInteger)numofTotal {
    
    if(self = [super initWithFrame:frame]){
        
        
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(10, (frame.size.height-40)/2.0, 100, 40);
        _title.text = title;
        [self addSubview:_title];
        
        _show = [[UILabel alloc] init];
        _show.frame = CGRectMake(frame.size.width-50, (frame.size.height-20)/2.0, 40, 20);
        NSString *showContent = [NSString stringWithFormat:@"%ld/%ld",(long)numOfOnline,numofTotal];
        _show.text = showContent;
        [self addSubview:_show];
    }
    
    return self;
}

@end
