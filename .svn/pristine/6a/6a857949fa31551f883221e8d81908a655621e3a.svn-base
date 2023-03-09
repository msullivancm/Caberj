/*/{Protheus.doc} CABA230

@project Aprovação de Borderôs
@description Função de uso genérico, para substituir a função padrão de "Aviso"
@author Rafael Rezende
@since 21/10/2022
@version 1.0		
@return
@see www.rgrsolucoes.com

/*/               

#Include "Protheus.ch"
#Include "TbiConn.ch"

*---------------------------------------------------------------------------------*
User Function RGRAviso( cParamTitulo, cParamMensagem, aParamBotoes, lParamFormata )
*---------------------------------------------------------------------------------*
Local nRetEscolha 		:= 0  
Default cParamMensagem  := "<h3><font style= 'color: black; backgroud-color: white;'>Você confirma ?</font></h3>"
Default cParamTitulo    := "Atenção!!"
Default aParamBotoes	:= { "Sim", "Não" } 
Default lParamFormata   := .T.
SetPrvt("oRGRAviso","oTitulo","oSayTitulo","oMensagem","oSayMensage","oBtn1","oBtn2","oBtn3","oBtn4")

If lParamFormata
	//cParamMensagem 	:= "<table border='0' width='100%' height='100%'><tr width='100%' height='100%' valign='middle'><td  width='100%' height='100%' bgcolor='darkblue'><h3><font color='white'>" + cParamMensagem + "</font></h3></td></tr></table>"
	cParamMensagem 	:= "<h3>" + cParamMensagem + "</h3>"
EndIf
/*
oRGRAviso  		:= MSDialog():New( 138,254,490,737, cParamTitulo,,,.F.,,,,,,.T.,,,.F. )
oTitulo    		:= TPanel():New( 000,000,"",oRGRAviso,,.F.,.F.,,,236,032,.T.,.F. )

oSayTitulo 		:= TSay():New( 000, 003,{|| cParamTitulo },oTitulo  ,,,.F. ,.F. ,.F. ,.T. ,CLR_WHITE ,CLR_BLUE  ,229,031 ,,,,,, .T. )
oMensagem    	:= TPanel():New( 032,000,"",oRGRAviso,,.F.,.F.,,,236,106,.T.,.F. )
oSayMensagem 	:= TSay():New( 004,000,{|| cParamMensagem },oMensagem,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,235,101 ,,,,,, .T. )
*/

oRGRAviso  		:= MSDialog():New( 138,249,353,737, cParamTitulo,,,.F.,,,,,,.T.,,,.F. )

//oSayTitulo 		:= TSay():New( 004,007,{|| cParamTitulo },oRGRAviso,,,.F.,.F.,.F.,.T.,CLR_WHITE,CLR_BLUE,223,009 ,,,,,, .T. )
oSayMensagem 	:= TSay():New( 016,011,{|| cParamMensagem },oRGRAviso,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,216,053 ,,,,,, .T. )
oSayMensagem:lWordWrap = .T.
	
If Len( aParamBotoes ) >= 01 
	//oBtn1      := TButton():New( 076,179,"",oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	//oBtn1      		:= TButton():New( 144,179, aParamBotoes[01],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn1      		:= TButton():New( 076,179, aParamBotoes[01],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn1:bAction 	:= { || nRetEscolha := 01, oRGRAviso:End() }
	oBtn1:Refresh()
EndIf

If Len( aParamBotoes ) >= 02 
	//oBtn2      := TButton():New( 076,123,"",oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	//oBtn2      := TButton():New( 144,123,aParamBotoes[02],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 076,123,aParamBotoes[02],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn2:bAction 	:= { || nRetEscolha := 02, oRGRAviso:End() }
	oBtn2:Refresh()
EndIf

If Len( aParamBotoes ) >= 03 
	//oBtn3      := TButton():New( 076,067,"",oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	//oBtn3      := TButton():New( 144,067,aParamBotoes[03],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 076,067,aParamBotoes[03],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn3:bAction 	:= { || nRetEscolha := 03, oRGRAviso:End() }
	oBtn3:Refresh()
EndIf

If Len( aParamBotoes ) >= 04 
	oBtn4      := TButton():New( 076,007,aParamBotoes[04],oRGRAviso,,050,019,,,,.T.,,"",,,,.F. )
	oBtn4:bAction 	:= { || nRetEscolha := 04, oRGRAviso:End() }
	oBtn4:Refresh()
EndIf

oRGRAviso:Activate(,,,.T.)

Return nRetEscolha


User Function TSTAVRGR()

MSGYESNO( cValToChar( U_RGRAviso() ) ) 
MSGYESNO( cValToChar( U_RGRAviso( "<h1> TESTE FONTE GRANDE!</H1>", "TESTE RGR", { "Ok" } ) ) )

nRet := U_RGRAviso( "<h1> O que Gostaria de Fazer?</H1>", Nil, { "Gravar", "Excluir", "Sair" } )  
Do CASE
	Case nRet == 1
		MsgYesNo( "Gravando" )
	Case nRet == 2
		MsgYesNo( "Excluindo" )
OtherWise
		MsgYesNo( "Saindo" )
EndCase

nRet := U_RGRAviso( "O que Gostaria de Fazer?", Nil, { "Gravar", "Excluir", "Sair" }, .t. )  

Return 
