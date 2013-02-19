//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by Tatiana Kornilova on 2/15/13.
//  Copyright (c) 2013 Tatiana Kornilova. All rights reserved.
//

#import "SuperCardViewController.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SuperCardViewController ()

@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@property (strong, nonatomic) Deck *deck;
@end

@implementation SuperCardViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
        return _deck;
}

-(void)setSetCardView:(SetCardView *)setCardView
{
    _setCardView = setCardView;
    [self drawRandomSetCard];
//    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
//                         initWithTarget:playingCardView
//                                   action:@selector(pinch:)]];
}
-(void)drawRandomSetCard
{
    Card *card = [self.deck drawRandomCard];

    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard =(SetCard *)card;
/*
        setCard.shape =@"squiggle";  /// ????
        setCard.rank =3; //?????
        setCard.shading =2; // ????
        setCard.color =2; //  ?????
*/        
        self.setCardView.rank =setCard.rank;
        self.setCardView.shape =setCard.shape;
        self.setCardView.color =setCard.color;
        self.setCardView.shading = setCard.shading;

    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
     [UIView transitionWithView:self.setCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.setCardView.faceUp) [self drawRandomSetCard];
                        self.setCardView.faceUp = !self.setCardView.faceUp;
                    }
                    completion:NULL];
}
@end
