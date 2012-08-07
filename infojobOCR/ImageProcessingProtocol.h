//
//  ImageProcessingProtocol.h
//  InfojobOCR
//
//  Created by Paolo Tagliani on 10/05/12.
//  Copyright (c) 2012 26775. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageProcessingProtocol <NSObject>
- (UIImage*) processImage:(UIImage*) src;
- (NSString*) OCRImage:(UIImage*)src;
- (UIImage*) processRotation:(UIImage*)src;
- (UIImage*) processHistogram:(UIImage*)src;
- (UIImage*) processFilter:(UIImage*)src;
- (UIImage*) processBinarize:(UIImage*)src;
@end