//
//  UIImageView+SDWebCache.m
//  SDWebData
//
//  Created by stm on 11-7-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SDImageView+SDWebCache.h"

@implementation UIImageView(SDWebCacheCategory)

- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url refreshCache:NO];
}

- (void)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache
{
	[self setImageWithURL:url refreshCache:refreshCache placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache placeholderImage:(UIImage *)placeholder
{
    SDWebDataManager *manager = [SDWebDataManager sharedManager];
	
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
	
    self.image = placeholder;
	
    if (url)
    {
        [manager downloadWithURL:url delegate:self refreshCache:refreshCache];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebDataManager sharedManager] cancelForDelegate:self];
}

- (void)setImageWithURL:(NSURL *)url withPalceholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url refreshCache:NO placeholderImage:placeholder];
}

#pragma mark -
#pragma mark SDWebDataManagerDelegate

- (void)webDataManager:(SDWebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache
{
	UIImage *img=[UIImage imageWithData:aData];
    self.image=img;
}

@end
