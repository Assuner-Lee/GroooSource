//
//  GRUser.h
//  GroooSource
//
//  Created by Assuner on 2017/2/14.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUser : NSObject

//********************* jsonData *******************

@property (nonatomic, assign) NSUInteger userID;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *schoolName;

@property (nonatomic, assign) double score;

//********************* localData *******************

@property (nonatomic, strong) NSString *building;

@property (nonatomic, strong) NSString *address;


@end
