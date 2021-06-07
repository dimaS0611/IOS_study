#import "LevelOrderTraversal.h"
#import <Foundation/Foundation.h>

@interface Node : NSObject

    @property int value;
    @property Node *left;
    @property Node *right;

- (id)initWithValue:(int)value;

@end

@implementation Node

-(id) initWithValue:(int)value
{
    self = [super init];
    
    if(self != nil)
    {
        self.value = value;
        self.left = nil;
        self.right = nil;
    }
    return self;
}

@end

@interface Tree : NSObject

- (Node *)insertNode: (Node *)node data:(int)value;
- (Node *)createTree: (NSArray *)treeData root:(Node *)root;
- (NSMutableArray *)levelOrder:(Node *)node;

@end

@implementation Tree

- (Node *)insertNode:(Node *)node data:(int)value
{
    if(node == nil)
    {
        Node *newNode= [[Node alloc] initWithValue: value];
        return newNode;
    }
    else
    {
        if(value <= node.value)
            node.left = [self insertNode:node.left data:value];
        else
            node.right = [self insertNode:node.right data:value];
        
        return node;
    }
}

- (Node *)createTree:(NSArray *)treeData root:(Node *)root
{
    root.value = [[treeData objectAtIndex:0] intValue];
    
    int idx = 1;
    while (idx < (int)[treeData count])
    {
        if([treeData objectAtIndex: idx] == [NSNull null])
            root = [self insertNode: root data: [NSNull null]];
        else
            root = [self insertNode: root data: [[treeData objectAtIndex: idx] intValue]];
        idx++;
    }
    return root;
}

- (NSMutableArray *)levelOrder:(Node *)node
{
    NSMutableArray *levelOrder = [NSMutableArray array];
    
    if(node == nil)
        return levelOrder;
    
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject: node];
    
    while([queue count] != 0)
    {
        NSMutableArray<Node *> *level = [NSMutableArray array];

        for(int i = 0; i < [queue count]; ++i)
        {
            Node *node = [queue firstObject];
            [queue removeObjectAtIndex: 0];
            
            [level addObject: node];
            if([node left]) {
                [queue addObject:[node left]];
            }
            if([node right])
            {
                [queue addObject:[node right]];
            }
        }
        NSMutableArray *intLevel = [NSMutableArray array];
        for(int i = 0; i < [level count]; ++i)
        {
            if([[level objectAtIndex: i] value] >= 0)
                [intLevel addObject: @([[level objectAtIndex: i] value])];
        }
        [levelOrder addObject: intLevel];
    }
    
    return levelOrder;
}

@end

NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    Node *root = [[Node alloc] init];
    Tree *binaryTree = [[Tree alloc] init];
    
    root = [binaryTree createTree: tree root: root];
    NSMutableArray *order = [NSMutableArray arrayWithArray: [binaryTree levelOrder: root]];
    
    return order;
}
