//
//  MDFile.m
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import "MDFile.h"


#define MD_DEBUG 1

#if MD_DEBUG
#define MDLog(...) NSLog(__VA_ARGS__)
#else
#define MDLog(...)
#endif

@implementation MDFile

- (instancetype)initWithFileURL:(NSURL *)fileURL {
	if ((self = [super init])) {
		_fileURL = fileURL;
		_kind = NSLocalizedString(@"Document", @"");
	}
	return self;
}

- (void)dealloc {
	MDLog(@"[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), _fileURL.lastPathComponent);
}

@end
