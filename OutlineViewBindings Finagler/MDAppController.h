//
//  MDAppController.h
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import <Cocoa/Cocoa.h>

@class MDTreeNode;


@interface MDAppController : NSObject <NSApplicationDelegate, NSMenuDelegate, NSOutlineViewDelegate, NSOutlineViewDataSource>

@property (strong) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSOutlineView 					*fileNodesOutlineView;

@property (weak) IBOutlet NSTreeController 					*fileNodesController;

@property (nonatomic, strong) NSMutableArray<MDTreeNode *>	*fileNodes;

- (IBAction)remove:(id)sender;

@end

