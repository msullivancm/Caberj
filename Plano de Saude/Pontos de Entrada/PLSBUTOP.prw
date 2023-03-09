#include "RWMAKE.CH"
#include "PLSMGER.CH"

/*                                                  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSBUTOP  บAutor  ณLuzio Tavares       บ Data ณ  22/06/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณModifica o array para apresentar os botoes na rotina de     บฑฑ
ฑฑบ          ณrecepcao.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
aPTBot[1] - "Pesquisar Agenda - <F4>
aPTBot[2] - "Cancelar Agenda - <F6>"
aPTBot[3] - "Marcacao Consulta - <F7>"
aPTBot[4] - "Encaminhamento - <F8>"
aPTBot[5] - "Atestado M้dico - <F10>"
aPTBot[6] - "Pronto Atendimento - <F11>"
aPTBot[7] - "Encaixe - <F12>"
aPTBot[8] - "Telefones Uteis - <CTRL + T>"
aPTBot[9] - "Ativa/Desativa Pausa - <CTRL + P>"
aPTBot[10] - "Carencias - <ALT + N>"
aPTBot[11] - "Abre/Fecha salas - <CTRL + F>"
aPTBot[12] - "Informar Chamada de paciente"
aPTBot[16] - "Desabilita o botao da Biometria mesmo que o parametro estaja ligado"
*/

User Function PLSBUTOP()
Local cNomeFun := paramixb[1]  //aParamIBX[1]
Local lBiomet := SuperGetMv("MV_BIOCONF",,.F.)

Local aPTBot  := {.T.,.T.,.T.,.F.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}  //Aqui esta sendo inibido o botao de encaminhamento
              

If alltrim(Funname())== "PLSA094B" //Alex Malheiro -11/10/2010 - Habilitado botใo se for chamado pela fun็ใo PLSA094B, Atendendo chamado 564.
	if lBiomet
		aPTBot := {.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
	EndIf 
else
	
	if lBiomet
		aPTBot := {.T.,.T.,.T.,.F.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.,.T.}
	EndIf                        
ENDIF
Return(aPTBot)