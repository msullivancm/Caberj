#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABV015   บAutor  ณLeonardo Portella   บ Data ณ  09/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValidacao do modo de edicao do campo BE4_DATPRO, BE4_HORPRO บฑฑ
ฑฑบ          ณBE4_DTALTA e BE4_HRALTA.                                    บฑฑ
ฑฑบ          ณNa importacao prestadores enviam data de alta e inicio de   บฑฑ
ฑฑบ          ณinternacao como alta/internacao administrativa e o sistema  บฑฑ
ฑฑบ          ณaltera conforme informado no XML, porem estas nao corres-   บฑฑ
ฑฑบ          ณpondem a data de alta/internacao reais, sao apenas adminis- บฑฑ
ฑฑบ          ณtrativas.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABV015

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณConforme orientacao de Joana e Agda, solicito acesso para alterar a data de internacao hospitalar para os seguintes usuarios:ณ
//ณ                                                                                                                             ณ
//ณAnalistas                                                                                                                    ณ
//ณWallace Oliveira - 000334                                                                                                    ณ
//ณWallace Viana - 000242                                                                                                       ณ
//ณCarlos Roberto Hing - 000341                                                                                                 ณ
//ณElizete Batista - 000109                                                                                                     ณ
//ณPatricia Paz - 000110                                                                                                        ณ
//ณRicardo Augusto Fialho - 000111                                                                                              ณ
//ณNilda Coelho - 000108                                                                                                        ณ
//ณMarcelo Oliveira - 000778                                                                                                    ณ
//ณJoseane Castro - 000780                                                                                                      ณ
//ณ                                                                                                                             ณ
//ณDigitadores                                                                                                                  ณ
//ณMarcio Andre Fernandez - 000299                                                                                              ณ
//ณWalcinea Francisca dos Santos - 000190                                                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//MV_XALDTAL - ALtera DaTa da ALta
Local cUsrAut 	:= GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN') + '|' + GetNewPar('MV_XALDTAL','000334|000242|000341|000109|000110|000111|000108|000778|000780|000299|000190')
Local lEdita	

lEdita	:= ( RetCodUsr() $ cUsrAut ) 

Return lEdita