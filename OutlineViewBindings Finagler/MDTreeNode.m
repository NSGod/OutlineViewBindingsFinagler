//
//  MDTreeNode.m
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import "MDTreeNode.h"
#import "MDFile.h"

#define MD_DEBUG 1

#if MD_DEBUG
#define MDLog(...) NSLog(__VA_ARGS__)
#else
#define MDLog(...)
#endif

@implementation MDTreeNode

- (void)dealloc {
	MDLog(@"[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [self.representedObject fileURL].lastPathComponent);
}

- (NSUInteger)countOfChildNodes {
	return self.childNodes.count;
}

@end
