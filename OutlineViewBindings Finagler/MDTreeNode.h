//
//  MDTreeNode.h
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDTreeNode : NSTreeNode

@property (readonly, nonatomic, assign) NSUInteger 	countOfChildNodes;

@end

NS_ASSUME_NONNULL_END
