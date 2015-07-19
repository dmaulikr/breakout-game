//
//  EndScene.m
//  Breakout-Game
//
//  Created by Jason on 6/29/14.
//  Copyright (c) 2014 Brelsford Software. All rights reserved.
//

#import "EndScene.h"
#import "MyScene.h"



@implementation EndScene
-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        SKAction *play = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
        [self runAction:play];
        
        //create message
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"GAME OVER!";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 25;
        label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:label];
        
      
        
        //second label
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        //tryAgain.text = [NSString stringWithFormat:@"%d",myscore];
        tryAgain.fontColor = [SKColor whiteColor];
        tryAgain.fontSize = 24;
        tryAgain.position = CGPointMake(size.width/2, -50);
        SKAction *moveLabel = [SKAction moveToY:(size.height/2 - 40) duration:0.5];
        [tryAgain runAction:moveLabel];
        [self addChild:tryAgain];
        
        //add banner to final game over screen
//        SKADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
 //       [self.view addSubview:adView];
      
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenVerticalWithDuration:1.2]];
}

@end
