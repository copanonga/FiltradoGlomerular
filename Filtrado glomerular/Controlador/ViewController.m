//
//  ViewController.m
//  Filtrado glomerular
//
//  Created by Jose on 25/4/18.
//  Copyright © 2018 Copanonga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *listadoEdad;
}
@property (weak, nonatomic) IBOutlet UITableView *tablaEdad;
@end

@implementation ViewController
@synthesize tablaEdad;

- (void)viewDidLoad {
    
    NSLog(@"\nViewController");
    listadoEdad = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self crearEdad];
    [tablaEdad reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)crearEdad {
    
    listadoEdad = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i < 120 ; i++)
        [listadoEdad addObject:[NSNumber numberWithInt:i]];
    
    for (int i = 0 ; i < [listadoEdad count] ; i++)
        NSLog(@"Edad: %i", [[listadoEdad objectAtIndex:i] intValue]);
    
}

#pragma mark - Tabla edad

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listadoEdad count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"listado";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *dato = [NSString stringWithFormat:@"%i",[[listadoEdad objectAtIndex:indexPath.row] intValue]];
    cell.textLabel.text = dato;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
