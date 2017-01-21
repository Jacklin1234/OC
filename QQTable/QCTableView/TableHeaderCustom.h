//
//  TableHeaderCustom.h
//  QQTable
//
//  Created by Husky on 8/12/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderCustom : UIView
{
    UIButton* _button;
    UILabel* _title;
    UILabel* _show;
}

-(instancetype) initWithFrame:(CGRect)frame titles:(NSString*) title numOfOnline:(NSInteger)numOfOnline numofTotal:(NSInteger)numofTotal;

@end
