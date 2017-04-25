//
//  QuestionTableViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initQuestionCell];
    }
    return self;
}

- (void)initQuestionCell{
    
    
}

- (void)updateUIWithIndex:(NSInteger)index question:(ExerciseQuestion *)question{
    
    
}

@end
