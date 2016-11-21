//
//  GitRepo.h
//  W4D1---GitHubRepos
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitRepo : NSObject

@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithName:(NSString*)name andURL:(NSURL*)url;


@end
