#import "TwoDimensionalArraySorter.h"

@implementation TwoDimensionalArraySorter

- (NSArray *)twoDimensionalSort:(NSArray<NSArray *> *)array {
    NSMutableArray *sortArr = [NSMutableArray array];
    
    for(int i = 0; i < [array count]; i++)
    {
        NSArray *arr = [array objectAtIndex:i];
        
        @try
        {
            for(int j = 0; j < [arr count]; j++) {
                [sortArr addObject:[arr objectAtIndex:j]];
            }
        }
        @catch(NSException *ex) {
            return @[];
        }
    }
    
    sortArr = [NSMutableArray arrayWithArray:[sortArr sortedArrayUsingSelector: @selector(compare:)]];
    
    return sortArr;
}

@end
