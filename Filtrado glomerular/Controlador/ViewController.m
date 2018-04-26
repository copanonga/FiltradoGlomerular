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
    NSMutableArray *listadoPeso;
}
@property (weak, nonatomic) IBOutlet UITableView *tablaPeso;
@property (weak, nonatomic) IBOutlet UITableView *tablaEdad;
@end

@implementation ViewController
@synthesize tablaEdad, tablaPeso;

- (void)viewDidLoad {
    
    NSLog(@"\nViewController");
    listadoEdad = [[NSMutableArray alloc] init];
    listadoPeso = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    
    [self crearEdad];
    [tablaEdad reloadData];
    
    [self crearPeso];
    [tablaPeso reloadData];

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

-(void)crearPeso {
    
    listadoPeso = [[NSMutableArray alloc] init];
    
    for (float i = 1 ; i < 10 ; i = i + 0.1){
        [listadoPeso addObject:[NSNumber numberWithFloat:i]];
    }
    
    for (int i = 0 ; i < [listadoPeso count] ; i++)
        NSLog(@"Peso: %f", [[listadoPeso objectAtIndex:i] floatValue]);
    
}

#pragma mark - Tabla edad

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:tablaEdad])
        return [listadoEdad count];
    
    if ([tableView isEqual:tablaPeso])
        return [listadoEdad count];
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:tablaEdad]) {
        
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
    
    if ([tableView isEqual:tablaPeso]) {
        
        static NSString *cellIdentifier = @"listado";
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        NSString *dato = [NSString stringWithFormat:@"%.01f",[[listadoPeso objectAtIndex:indexPath.row] floatValue]];
        cell.textLabel.text = dato;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        return cell;
        
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
