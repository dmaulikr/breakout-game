//
//  MyScene.m
//  Breakout-Game
//
//  Created by Jason on 5/28/14.
//  Copyright (c) 2014 Brelsford Software. All rights reserved.
//

#import "MyScene.h"
#import "EndScene.h"

@interface MyScene ()



@property (nonatomic) SKSpriteNode *paddle;


@end

static const uint32_t ballCategory =1;      //00000000000000000000000000000001
static const uint32_t brickCategory = 2;    //00000000000000000000000000000010
static const uint32_t paddleCategory = 4;   //00000000000000000000000000000100
static const uint32_t edgeCategory = 8;     //00000000000000000000000000001000
static const uint32_t bottomEdgeCategory = 32;      //00000000000000000000000000010000


@implementation MyScene


-(void)didScore
{
// myscore = (myscore +1);
}


//-(void) LabelDisplay
//{
//   
//    SKLabelNode *scoreLabel= [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
//    scoreLabel.text = @"score",0;
//    scoreLabel.fontColor = [SKColor blackColor];
//    scoreLabel.fontSize = 24 ;
//    scoreLabel.position = CGPointMake(1, 1);
//    scoreLabel.text = [NSString stringWithFormat:@"Score:%i",score];
//    [self addChild:scoreLabel];
//}

     

-(void)didBeginContact:(SKPhysicsContact *)contact{
//    if (contact.bodyA.categoryBitMask == brickCategory){
//        NSLog(@"bodyA is a brick!");
//        [contact.bodyA.node removeFromParent];
//    }
//    if (contact.bodyB.categoryBitMask == brickCategory){
//        NSLog(@"bodyB is a brick!");
//        [contact.bodyB.node removeFromParent];
//    }
    
    
    SKPhysicsBody *notTheBall;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
    } else {
        notTheBall = contact.bodyA;
        }
    if (notTheBall.categoryBitMask == brickCategory) {
        SKAction *playSFX = [SKAction playSoundFileNamed:@"brickhit.caf" waitForCompletion:NO];
        [self runAction:playSFX];
        

    [notTheBall.node removeFromParent];
        [self addOneBrick:1 size:[self size] spriteName:@"RedBricksmall"];
        [self addOneBrick:3 size:[self size] spriteName:@"RedBricksmall"];
      //[self didScore];
        
        
    }
    if (notTheBall.categoryBitMask == paddleCategory){
        SKAction *playSFX = [SKAction playSoundFileNamed:@"blip.caf" waitForCompletion:NO];
        [self runAction:playSFX];
    }
    if (notTheBall.categoryBitMask == bottomEdgeCategory) {
        EndScene *end = [EndScene sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition doorsCloseVerticalWithDuration:1.0]];
        
    }
    if((contact.bodyA.categoryBitMask == ballCategory &&
        contact.bodyB.categoryBitMask == brickCategory) ||
       (contact.bodyA.categoryBitMask == brickCategory &&
        contact.bodyB.categoryBitMask == ballCategory)) {
           [self addBall:[self size]];
       }

}


-(void) addBottomEdge: (CGSize) size {
    SKNode *bottomEdge =[SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0,1) toPoint:CGPointMake(size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
}


- (void)addBall:(CGSize)size {
    // create a new sprite node from an image
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ballresized"];
    
    //create a CGPoint for position
    CGPoint myPoint =CGPointMake(size.width/3, size.height/2);
    ball.position = myPoint;
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction=0;
    ball.physicsBody.linearDamping=0;
    ball.physicsBody.restitution=1;
    ball.physicsBody.categoryBitMask = ballCategory;
    ball.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
    // ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;
    
    
    
    //add the sprite node to the scene
    [self addChild:ball];
    
    //create the vector
    CGVector myVector = CGVectorMake(1,1);
    //apply to ball
    [ball.physicsBody applyImpulse:myVector];
}



//- (void)addBall2:(CGSize)size {
////    // create a new sprite node from an image
//    
////this was a way to explode 10 balls from a brick
//   // for (int i = 0; i < 10; i++) {
//        // do some code
////sleep for two seconds before next release
//    //[NSThread sleepForTimeInterval:2.0f];
//    
//   SKSpriteNode *ball2 = [SKSpriteNode spriteNodeWithImageNamed:@"ballresized"];
//   
////    //create a CGPoint for position
//   CGPoint myPoint =CGPointMake(size.width/1, size.height/2);
//   ball2.position = myPoint;
////    
//   ball2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball2.frame.size.width/2];
//   ball2.physicsBody.friction=0;
//   ball2.physicsBody.linearDamping=0;
//   ball2.physicsBody.restitution=1;
//   ball2.physicsBody.categoryBitMask = ballCategory;
//   ball2.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
//   // ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;
//   
//   
////    
//  //add the sprite node to the scene
//  [self addChild:ball2];
////    
//  //create the vector
//  CGVector myVector = CGVectorMake(1,1);
//   //apply to ball
//  [ball2.physicsBody applyImpulse:myVector];
//}
//

//add ball 3

// - (void)addBall3:(CGSize)size {
//    // create a new sprite node from an image
//    
//    //this was a way to explode 10 balls from a brick
//    // for (int i = 0; i < 10; i++) {
//    // do some code
//    //sleep for two seconds before next release
//  
//    
//    
//    SKSpriteNode *ball3 = [SKSpriteNode spriteNodeWithImageNamed:@"ballresized"];
//    
//    //    //create a CGPoint for position
//    CGPoint myPoint =CGPointMake(size.width/2, size.height/2);
//    ball3.position = myPoint;
//    //
//    ball3.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball3.frame.size.width/2];
//    ball3.physicsBody.friction=1;
//    ball3.physicsBody.linearDamping=0;
//    ball3.physicsBody.restitution=1;
//    ball3.physicsBody.categoryBitMask = ballCategory;
//    ball3.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
//    // ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;
//    
//
//    //
//    //add the sprite node to the scene
//    [self addChild:ball3];
//    //
//    //create the vector
//    CGVector myVector = CGVectorMake(1,1);
//    //apply to ball
//    [ball3.physicsBody applyImpulse:myVector];
//}

- (void)addOneBrick:(int)i size:(CGSize)size spriteName:(NSString*)sprite{
    SKSpriteNode *brick =[SKSpriteNode spriteNodeWithImageNamed:sprite];
    
    //add a static physics body
    brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
    //brick.physicsBody.dynamic = NO;
    brick.physicsBody.categoryBitMask =brickCategory;
    brick.physicsBody.friction=0;
    brick.physicsBody.linearDamping=0;
    brick.physicsBody.restitution=1;
    brick.physicsBody.categoryBitMask =brickCategory;
    
    int xPos =size.width/9 * (i+1);
    int yPos = size.height - 50;
    brick.position = CGPointMake(xPos, yPos);
    
    [self addChild:brick];
    
    CGVector myVector = CGVectorMake(0,-7);
    //apply to bricks
    [brick.physicsBody applyImpulse:myVector];
}

//put in some bricks
-(void) addBricks:(CGSize) size {
    for (int i= 0; i< 10; i++) {
        [self addOneBrick:i size:size spriteName:@"Bricksmall"];
    }
}

-(void) addBrick2:(CGSize) size {
    for (int i= 0; i< 10; i++) {
        SKSpriteNode *brick2 =[SKSpriteNode spriteNodeWithImageNamed:@"Bricksmall"];
        
        //add a static physics body
        brick2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick2.frame.size];
        //brick2.physicsBody.dynamic = NO;
        brick2.physicsBody.categoryBitMask =brickCategory;
        brick2.physicsBody.friction=0;
        brick2.physicsBody.linearDamping=0;
        brick2.physicsBody.restitution=1;
        brick2.physicsBody.categoryBitMask =brickCategory;
        int xPos =size.width/9 * (i+1);
        int yPos = size.height - 90;
        brick2.position = CGPointMake(xPos, yPos);
        
        [self addChild:brick2];
        CGVector myVector = CGVectorMake(0,-7);
        //apply to bricks
        [brick2.physicsBody applyImpulse:myVector];
    }
}

-(void) addBrick3:(CGSize) size {
    for (int i= 0; i< 9; i++) {
        SKSpriteNode *brick3 =[SKSpriteNode spriteNodeWithImageNamed:@"Bricksmall"];
        
        //add a static physics body
        brick3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick3.frame.size];
        brick3.physicsBody.dynamic = NO;
        brick3.physicsBody.friction=0;
        brick3.physicsBody.linearDamping=0;
        brick3.physicsBody.restitution=1;
        brick3.physicsBody.categoryBitMask =brickCategory;
        
        int xPos =size.width/10 * (i+1);
        int yPos = size.height - 120;
        brick3.position = CGPointMake(xPos, yPos);
        
        [self addChild:brick3];
        CGVector myVector = CGVectorMake(0,-7);
        //apply to bricks
        [brick3.physicsBody applyImpulse:myVector];
    }
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches ) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition =CGPointMake(location.x,100);
        
        
        //stop the paddle going too far
        if  (newPosition.x < self.paddle.size.width/2) {
            newPosition.x = self.paddle.size.width/2;
        }
        if (newPosition.x > self.size.width - (self.paddle.size.width /2)) {
            newPosition.x = self.size.width - (self.paddle.size.width/2);
            }
            self.paddle.position =newPosition;

    }
}

        //add player
-(void) addPlayer:(CGSize)size {
    //create paddle sprite
    self.paddle =[SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    //position the paddle
    self.paddle.position = CGPointMake(size.width/2,100);
    //add physics body
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    //make it static
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddleCategory;
    
    //add to scene
    [self addChild:self.paddle];

    
}
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor whiteColor ];
        
        // add a physics body to the scene
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        
        //change gravity settings
        self.physicsWorld.gravity =CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        [self addBall:size];
        [self addPlayer:size];
        [self addBricks:size];
        [self addBottomEdge:size];
//        [self addBall2:size];
        [self addBrick2:size];
        [self addBrick3:size];
//        [self addBall3:size];
        
}
    return self;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
