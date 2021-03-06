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
@property (weak, nonatomic) IBOutlet UITextField *textFieldCockcroftGault;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerEdad;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerPeso;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentGenero;

@property (weak, nonatomic) IBOutlet UILabel *labelFiltradoGlomerular;
@property (weak, nonatomic) IBOutlet UILabel *labelEdad;
@property (weak, nonatomic) IBOutlet UILabel *labelPeso;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatininaEnPlasma;
@property (weak, nonatomic) IBOutlet UILabel *labelCockcroftGault;

@end

@implementation ViewController
@synthesize textFieldEdad, textFieldPeso, textFieldCreatinina, textFieldCockcroftGault;
@synthesize pickerEdad, pickerPeso;
@synthesize segmentGenero;
@synthesize labelFiltradoGlomerular, labelEdad, labelPeso, labelCreatininaEnPlasma, labelCockcroftGault;

int const EDAD_MAXIMA = 121;
int const PESO_MAXIMO = 151;

int const EDAD_INICIAL = 29;
float const PESO_INICIAL = 690;

- (void)viewDidLoad {
    
    NSLog(@"\nViewController");
    
    [self inicializarTextos];
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

-(void)inicializarTextos {
    
    labelFiltradoGlomerular.text = NSLocalizedString(@"CFBundleDisplayName", nil);
    labelEdad.text = NSLocalizedString(@"Edad", nil);
    labelPeso.text = NSLocalizedString(@"Peso", nil);
    labelCreatininaEnPlasma.text = NSLocalizedString(@"Creatinina en plasma", nil);
    labelCockcroftGault.text = NSLocalizedString(@"Cockcroft-Gault", nil);
    
    [segmentGenero setTitle:NSLocalizedString(@"Hombre", nil) forSegmentAtIndex:0];
    [segmentGenero setTitle:NSLocalizedString(@"Mujer", nil) forSegmentAtIndex:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Calcular Cockcroft-Gault

-(void)calculoCockcroftGault {
    
    creatininaSeleccionada = [textFieldCreatinina.text floatValue];
    NSLog(@"Edad: %i", edadSeleccionada);
    NSLog(@"Peso: %.01f", pesoSeleccionado);
    NSLog(@"Creatinina: %.03f", creatininaSeleccionada);
    
    if (creatininaSeleccionada==0){
        textFieldCockcroftGault.text = [NSString stringWithFormat:@""];
        return;
    }
    
    float factor_sexo = 0;
    
    if (generoSeleccionado) {
        NSLog(@"Género: mujer");
        factor_sexo = 0.85;
    } else {
        NSLog(@"Género: hombre");
        factor_sexo = 1;
    }
    
    float resultado = (((140 - edadSeleccionada) * pesoSeleccionado) / (72 * creatininaSeleccionada)) * factor_sexo;
    NSLog(@"Resultado: %f", resultado);
    
    textFieldCockcroftGault.text = [NSString stringWithFormat:@"%.03f ml/min", resultado];
    
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

#pragma mark - Botones

- (IBAction)botonConfiguracion:(id)sender {

    NSLog(@"Configuración");
    [self mostrarConfiguracion];

}

#pragma mark - Textos

//https://code.tutsplus.com/tutorials/ios-sdk-uitextfield-uitextfielddelegate--mobile-10943

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    //textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    [self calculoCockcroftGault];
    //textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    [self calculoCockcroftGault];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:");
    [self calculoCockcroftGault];
    if ([string isEqualToString:@"#"]) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Utilidades

-(void) compartirTexto: (NSString *) textoAEnviar {
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[textoAEnviar]
                                      applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                              
                                          }];
    
}

-(void)mostrarConfiguracion {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Configuración", nil)
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelar = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Cancelar", nil)
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Cancel action");
                               }];
    
    UIAlertAction *idioma = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Idioma", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 
                             }];
    
    UIAlertAction *compartir = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Compartir", nil)
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 
                                 NSMutableString *textoACompartir = [[NSMutableString alloc] init];
                                 [textoACompartir appendString:NSLocalizedString(@"CFBundleDisplayName", nil)];
                                 [textoACompartir appendString:@" - "];
                                 [textoACompartir appendString:@"https://itunes.apple.com/app/"];
                                 [self compartirTexto:textoACompartir];
                                 
                             }];
    
    
    [alertController addAction:cancelar];
    [alertController addAction:idioma];
    [alertController addAction:compartir];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
