//
//  MDFile.h
//  OutlineViewBindings Finagler
//
//  Created by Mark Douma on 12/26/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDFile : NSObject

@property (nonatomic, strong) NSURL			*fileURL;
@property (nonatomic, strong) NSString		*kind;

- (instancetype)initWithFileURL:(NSURL *)fileURL;


@end

NS_ASSUME_NONNULL_END
