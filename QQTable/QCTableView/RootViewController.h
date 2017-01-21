//
//  RootViewController.h
//  QCTableView
//
//  Created by Husky on 8/9/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tv;
    NSMutableArray* _arrayData;
    NSMutableArray* _rootArray;
    NSDictionary* _rootDic;
    NSMutableArray* _groupName;
    NSMutableArray* _groupArray;
    NSMutableArray* _friendArray;
    NSMutableArray* _numOfCells;
}

@end
