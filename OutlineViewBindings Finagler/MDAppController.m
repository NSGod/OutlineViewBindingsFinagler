//
//  MDAppController.m
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import "MDAppController.h"
#import "MDFile.h"
#import "MDTreeNode.h"

#define MD_DEBUG 1

#if MD_DEBUG
#define MDLog(...) NSLog(__VA_ARGS__)
#else
#define MDLog(...)
#endif

@implementation MDAppController

- (instancetype)init {
	if ((self = [super init])) {
		_fileNodes = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
	_fileNodesOutlineView.stronglyReferencesItems = NO;
	[_fileNodesOutlineView registerForDraggedTypes:@[(NSString *)kUTTypeFileURL]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

#pragma mark - <NSOutlineViewDelegate>


#pragma mark - <NSOutlineViewDataSource>
- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id<NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(NSInteger)index {
	__block NSDragOperation dragOperation = NSDragOperationNone;
	[info enumerateDraggingItemsWithOptions:0
									forView:nil
									classes:@[[NSURL class]]
							  searchOptions:@{NSPasteboardURLReadingFileURLsOnlyKey: @(YES),
											  NSPasteboardURLReadingContentsConformToTypesKey: @[(NSString *)kUTTypeData]}
								 usingBlock:^(NSDraggingItem * _Nonnull draggingItem, NSInteger idx, BOOL * _Nonnull stop) {
		dragOperation = NSDragOperationCopy;
	}];
	return dragOperation;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id<NSDraggingInfo>)info item:(id)item childIndex:(NSInteger)index {
	NSPasteboard *pboard = info.draggingPasteboard;
	NSArray *URLs = [pboard readObjectsForClasses:@[[NSURL class]] options:@{NSPasteboardURLReadingFileURLsOnlyKey: @(YES),
																			 NSPasteboardURLReadingContentsConformToTypesKey: @[(NSString *)kUTTypeData]}];
	if (URLs) {
		MDLog(@"[%@ %@] URLs: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [URLs valueForKey:@"path"]);
		[self addItemsAtURLs:URLs];
	}
	return YES;
}

#pragma mark -
- (void)addItemsAtURLs:(NSArray<NSURL *> *)fileURLs {
	NSMutableArray<MDTreeNode *> *nodes = [NSMutableArray array];
	for (NSURL *fileURL in fileURLs) {
		MDFile *file = [[MDFile alloc] initWithFileURL:fileURL];
		if (file) {
			MDTreeNode *node = [[MDTreeNode alloc] initWithRepresentedObject:file];
			if (node) [nodes addObject:node];
		}
	}
	if (nodes.count) {
		NSMutableArray *indexPaths = [NSMutableArray array];
		for (NSUInteger i = 0; i < nodes.count; i++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
			[indexPaths addObject:indexPath];
		}
		[_fileNodesController insertObjects:nodes atArrangedObjectIndexPaths:indexPaths];
	}
	[_fileNodesOutlineView reloadData];
}

#pragma mark - <NSMenuValidation>
- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
	SEL action = menuItem.action;
	if (action == @selector(remove:)) {
		NSArray *selectionIndexPaths = _fileNodesController.selectionIndexPaths;
		MDLog(@"[%@ %@] selectionIndexPaths: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), selectionIndexPaths);
		return selectionIndexPaths.count > 0;
	}
	return NO;
}

- (IBAction)remove:(id)sender {
	MDLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
	[_fileNodesController removeObjectsAtArrangedObjectIndexPaths:_fileNodesController.selectionIndexPaths];
	MDLog(@"[%@ %@] fileNodes: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), _fileNodes);
}

#pragma mark -
- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
	return YES;
}

@end
