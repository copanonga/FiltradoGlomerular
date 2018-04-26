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

@property (weak, nonatomic) IBOutlet UITextField *textFieldEdad;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPeso;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCreatinina;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerEdad;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerPeso;

@end

@implementation ViewController
@synthesize textFieldEdad, textFieldPeso, textFieldCreatinina;
@synthesize pickerEdad, pickerPeso;

- (void)viewDidLoad {
    
    NSLog(@"\nViewController");
    
    [self inicializar];
    
    [super viewDidLoad];
    
    [self crearEdad];
    [self crearPeso];

}

-(void)inicializar {
    
    listadoEdad = [[NSMutableArray alloc] init];
    listadoPeso = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Crear datos de edad y peso

-(void)crearEdad {
    
    listadoEdad = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i < 120 ; i++)
        [listadoEdad addObject:[NSNumber numberWithInt:i]];
    
}

-(void)crearPeso {
    
    listadoPeso = [[NSMutableArray alloc] init];
    
    for (float i = 1 ; i < 10 ; i = i + 0.1){
        [listadoPeso addObject:[NSNumber numberWithFloat:i]];
    }
    
}

#pragma mark - Picker edad y peso

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:pickerEdad])
        return (int)[listadoEdad count];
    
    if ([pickerView isEqual:pickerPeso])
        return (int)[listadoPeso count];
    
    return 0;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:pickerEdad]) {
        NSString *dato = [NSString stringWithFormat:@"%i",[[listadoEdad objectAtIndex:row] intValue]];
        return dato;
    }
    
    if ([pickerView isEqual:pickerPeso]) {
        NSString *dato = [NSString stringWithFormat:@"%.01f",[[listadoPeso objectAtIndex:row] floatValue]];
        return dato;
    }
        
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:pickerEdad]) {
        NSString *dato = [NSString stringWithFormat:@"%i",[[listadoEdad objectAtIndex:row] intValue]];
        textFieldEdad.text = dato;
    }
    
    if ([pickerView isEqual:pickerPeso]) {
        NSString *dato = [NSString stringWithFormat:@"%.01f",[[listadoPeso objectAtIndex:row] floatValue]];
        textFieldPeso.text = dato;
    }

}

@end
