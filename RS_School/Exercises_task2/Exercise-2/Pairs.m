#import "Pairs.h"

@implementation Pairs

- (NSInteger)countPairs:(NSArray <NSNumber *> *)array number:(NSNumber *)number {
    
    NSInteger counter = 0;
    for(int i = 0; i < [array count]; i++)
    {
        for(int j = 0; j < [array count]; j++)
        {
            if(([[array objectAtIndex:j] intValue] - [[array objectAtIndex:i] intValue]) == [number intValue]) {
                counter++;
            }
        }
    }
    
    return counter;
}

@end
