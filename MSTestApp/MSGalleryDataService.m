//
//  MSGalleryDataService.m
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSGalleryDataService.h"
#import "MSGallery.h"

static NSString *const fetchGalleriesApi = @"https://api.imgur.com/3/gallery";
static NSString *const headerAuthorization = @"Client-ID e22fe6520bc98ae";

@implementation MSGalleryDataService

+ (void)fetchGalleryDataForSection:(NSString *)section sort:(NSString *)sort window:(NSString *)window page:(NSInteger)page showViral:(BOOL)showViral withCompletion:(void(^)(NSArray *galleries, NSError *error))completion
{
    NSURL *url = nil;
    
    if ([section isEqualToString:@"top"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/0.json?showViral=%@", fetchGalleriesApi, section, sort, window, @(page), @(showViral)]];
    }
    else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@/%@/0.json?showViral=%@", fetchGalleriesApi, section, sort, @(page), @(showViral)]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:headerAuthorization forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"Request Url : %@",request.URL);
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        if(jsonError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, jsonError);
            });
            return;
        }
        
        NSArray *array = [json objectForKey:@"data"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MSGallery *gallery = [[MSGallery alloc] initWithDictionary:obj];
            if (![gallery.is_album boolValue]) {
                [mutableArray addObject:gallery];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(mutableArray, nil);
        });
    }];
    [task resume];
}

@end
