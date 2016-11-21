//
//  GitRepo.m
//  W4D1---GitHubRepos
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "GitRepo.h"

@implementation GitRepo
- (instancetype)initWithName:(NSString*)name andURL:(NSURL*)url{

	self = [super init];
	if (self) {
		_name = name;
		_url = url;
	}
	return self;
}

@end
