//
//  friendList.h
//  QQTable
//
//  Created by Husky on 8/10/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface friendList : NSObject
{
    BOOL _isOnline;
    NSString* _headerImage;
    NSString* _name;
}

@property(nonatomic,retain) NSString* headerImage;
@property(nonatomic,retain) NSString* name;
@property(assign) BOOL isOnline;

@end
