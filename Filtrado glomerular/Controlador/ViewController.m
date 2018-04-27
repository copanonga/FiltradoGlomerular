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
    
    int edadSeleccionada;
    float pesoSeleccionado;
    float creatininaSeleccionada;
    BOOL generoSeleccionado;

}

@property (weak, nonatomic) IBOutlet UITextField *textFieldEdad;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPeso;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCreatinina;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerEdad;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerPeso;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentGenero;

@end

@implementation ViewController
@synthesize textFieldEdad, textFieldPeso, textFieldCreatinina;
@synthesize pickerEdad, pickerPeso;
@synthesize segmentGenero;

int const EDAD_MAXIMA = 121;
int const PESO_MAXIMO = 151;

int const EDAD_INICIAL = 29;
float const PESO_INICIAL = 690;

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
    
    edadSeleccionada = EDAD_INICIAL;
    pesoSeleccionado = PESO_INICIAL;
    creatininaSeleccionada = 0;
    generoSeleccionado = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Calcular Cockcroft-Gault

-(void)calculoCockcroftGault {
    
    NSLog(@"Edad: %i", edadSeleccionada);
    NSLog(@"Peso: %.01f", pesoSeleccionado);
    NSLog(@"Creatinina: %.03f", creatininaSeleccionada);
    
    if (generoSeleccionado)
        NSLog(@"Género: mujer");
    else
        NSLog(@"Género: hombre");
    
}

#pragma mark - Crear datos de edad y peso

-(void)crearEdad {
    
    listadoEdad = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i < EDAD_MAXIMA ; i++)
        [listadoEdad addObject:[NSNumber numberWithInt:i]];
    
    [pickerEdad selectRow:EDAD_INICIAL inComponent:0 animated:YES];
    edadSeleccionada = [[listadoEdad objectAtIndex:EDAD_INICIAL] intValue];
    textFieldEdad.text = [NSString stringWithFormat:@"%i %@",edadSeleccionada,NSLocalizedString(@"años", nil)];
    
}

-(void)crearPeso {
    
    listadoPeso = [[NSMutableArray alloc] init];
    
    for (float i = 1 ; i < PESO_MAXIMO ; i = i + 0.1)
        [listadoPeso addObject:[NSNumber numberWithFloat:i]];
    
    [pickerPeso selectRow:PESO_INICIAL inComponent:0 animated:YES];
    pesoSeleccionado = [[listadoPeso objectAtIndex:PESO_INICIAL] floatValue];
    textFieldPeso.text = [NSString stringWithFormat:@"%.01f %@",pesoSeleccionado,NSLocalizedString(@"kg", nil)];
    
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
    if ([pickerView isEqual:pickerEdad])
        return [NSString stringWithFormat:@"%i",[[listadoEdad objectAtIndex:row] intValue]];
    
    if ([pickerView isEqual:pickerPeso])
        return [NSString stringWithFormat:@"%.01f",[[listadoPeso objectAtIndex:row] floatValue]];
        
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:pickerEdad]) {
        edadSeleccionada = [[listadoEdad objectAtIndex:row] intValue];
        textFieldEdad.text = [NSString stringWithFormat:@"%i %@",edadSeleccionada,NSLocalizedString(@"años", nil)];
    }
    
    if ([pickerView isEqual:pickerPeso]) {
        pesoSeleccionado = [[listadoPeso objectAtIndex:row] floatValue];
        textFieldPeso.text = [NSString stringWithFormat:@"%.01f %@",pesoSeleccionado,NSLocalizedString(@"kg", nil)];
    }
    
    [self calculoCockcroftGault];
    
}

#pragma mark - Seleccionar género

- (IBAction)pulsarSegmentGenero:(id)sender {

    if (segmentGenero.selectedSegmentIndex == 0)
        generoSeleccionado = 0;
    
    if(segmentGenero.selectedSegmentIndex == 1)
        generoSeleccionado = 1;
    
    [self calculoCockcroftGault];
    
}

@end
