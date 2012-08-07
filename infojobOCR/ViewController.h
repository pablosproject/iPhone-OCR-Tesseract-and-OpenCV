//
//  ViewController.h
//  infojobOCR
//
//  Created by Paolo Tagliani on 08/06/12.
//  Copyright (c) 2012 26775. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingProtocol.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
    UIImagePickerController *mediaPicker;
    UIImage *takenImage;
    UIImage *processedImage;
}


@property (strong, nonatomic) IBOutlet UIButton *process;
@property (strong, nonatomic) IBOutlet UIImageView *resultView;
@property (strong, nonatomic) id <ImageProcessingProtocol> imageProcessor;
@property (strong, nonatomic) IBOutlet UIButton *read;
@property (strong,nonatomic) UIImage *takenImage;
@property (strong,nonatomic) UIImage *processedImage;
@property (strong, nonatomic) IBOutlet UIButton *rotateButton;
@property (strong, nonatomic) IBOutlet UIButton *Histogrambutton;
@property (strong, nonatomic) IBOutlet UIButton *FilterButton;
@property (strong, nonatomic) IBOutlet UIButton *BinarizeButton;
@property (strong, nonatomic) IBOutlet UIButton *originalButton;

- (IBAction)TakePhoto:(id)sender;
- (IBAction)Pre:(id)sender;
- (IBAction)OCR:(id)sender;
- (IBAction)PreRotation:(id)sender;
- (IBAction)PreHistogram:(id)sender;
- (IBAction)PreFilter:(id)sender;
- (IBAction)PreBinarize:(id)sender;
- (IBAction)returnOriginal:(id)sender;


- (IBAction)ChooseMedia:(id)sender;
- (UIView*)CreateOverlay;


@end