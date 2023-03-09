#include "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMBRWBTN   บAutor  ณLeonardo Portella   บ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de Entrada acionado em todas as MBROWSE do sistema.   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MBRWBTN()
       
Local lRet	:= .T.  

Private cAlias	:= PARAMIXB[1]//Alias da tabela ponteirada 
Private nRecno	:= PARAMIXB[2]//Recno ponteirado
Private nBotao	:= PARAMIXB[3]//Ordem do botao no browse 
Private cFuncao	:= allTrim(Upper(PARAMIXB[4]))//Nome da funcao que eh chamada pelo botao clicado no browse.     
//alert("MBRWBTN")

//Leonardo Portella - 05/10/11 - Inicio
//Substituido pelo PE PL365ROT

/*
Private cGETIN 	:= SuperGetMv('MV_XGETIN') 
Private cGERIN	:= SuperGetMv('MV_XGERIN')  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณValidacao no browse do RDA - Cadastro - para validar usuario queณ
//ณtem direito a alterar o RDA atraves da opcao Complemento.       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If cFuncao == 'PLSA365MNT' .and. ( ALTERA .or. INCLUI ) .and. !( RetCodUsr() $ SuperGetMv('MV_XRDACOM') ) .and. !( RetCodUsr() $ cGETIN )
   
    //Ate o dia 08/08/11 nao existia um ponto de entrada "TUDO OK" no PLSA365MNT, por isso coloco no modo de visualizacao alterando as 
    //variaveis publicas ALTERA e INCLUI.
	ALTERA := .F.
	INCLUI := .F.
	
	Aviso('ATENวรO','Somente serแ permitido visualizar este prestador.',{'Ok'})
	
EndIf
*/   

//Leonardo Portella - 05/10/11 - Fim

Return lRet