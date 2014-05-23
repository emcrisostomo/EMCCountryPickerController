//
//  UIImage+UIImage_EMCImageResize.m
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 17/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "UIImage+UIImage_EMCImageResize.h"

@implementation UIImage (UIImage_EMCImageResize)

- (UIImage *)fitInSize:(CGSize)newSize
{
    if (!newSize.height || !newSize.width)
    {
        [NSException raise:@"Invalid size." format:@"Size %f:%f is invalid.", newSize.width, newSize.height];
    }
    
    const CGFloat widthRatio = newSize.width / self.size.width;
    const CGFloat heightRatio = newSize.height / self.size.height;
    const CGFloat ratio = MIN(widthRatio, heightRatio);
    
    const CGFloat imageWidth = self.size.width * ratio;
    const CGFloat imageHeight = self.size.height * ratio;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

@end
