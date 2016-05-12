//
//  MSUtility.h
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSConstant.h"

@interface MSUtility : NSObject

+ (void)imageData:(NSURL *)url withCompletion:(void (^)( NSData *imageData, NSError *error))completion;
+ (NSString *)sectionString:(MSGallerySection)section;
+ (NSString *)sortString:(MSGallerySort)sort;
+ (NSString *)windowString:(MSGalleryWindowTime)sort;

@end
