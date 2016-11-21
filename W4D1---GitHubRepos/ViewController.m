//
//  ViewController.m
//  W4D1---GitHubRepos
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "ViewController.h"
#import "GitRepo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *objects;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/guiworm/repos"]; // 1
	NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
	
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		
		if (error) { // 1
					 // Handle the error
			NSLog(@"error: %@", error.localizedDescription);
			return;
		}
		
		NSError *jsonError = nil;
		NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
		
		if (jsonError) { // 3
						 // Handle the error
			NSLog(@"jsonError: %@", jsonError.localizedDescription);
			return;
		}
		
		NSMutableArray<GitRepo*> *repoObjects = [[NSMutableArray alloc] init];

		// If we reach this point, we have successfully retrieved the JSON from the API
		for (NSDictionary *repo in repos) { // 4
			
			NSString *repoName = repo[@"name"];
			NSLog(@"repo: %@", repoName);
			
			GitRepo *r = [[GitRepo alloc]
						  initWithName:repo[@"name"]
						  andURL:[NSURL URLWithString:repo[@"html_url"]]];
			[repoObjects addObject:r];
		}
		self.objects = [repoObjects copy];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.myTableView reloadData];
		});
	}];

	
	[dataTask resume]; // 6
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
	
	GitRepo *object = self.objects[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object.name, object.url];
	return cell;
}




@end
