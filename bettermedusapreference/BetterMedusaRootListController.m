#include "BetterMedusaRootListController.h"

#import <SpringBoard/SpringBoard.h>

@implementation BetterMedusaRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)respring {
	system("killall -9 SpringBoard");
}

@end
