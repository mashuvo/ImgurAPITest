//
//  MSGalleryDataService.h
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSGalleryDataService : NSObject

+ (void)fetchGalleryDataForSection:(NSString *)section sort:(NSString *)sort window:(NSString *)window page:(NSInteger)page showViral:(BOOL)showViral withCompletion:(void(^)(NSArray *galleries, NSError *error))completion;

@end
