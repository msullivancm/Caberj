#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA079   ºAutor  ³Motta               º Data ³  julho/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  CADASTRO DE RISCO X BENEFICIARIOS                         º±±
±±º          ³  FAZ A CHAMADA TAMBEM DA PROCEDURE                         º±±
±±º          ³  SIGA.GRAVA_RISCO_PROTOCOLO                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CABA079  

Private cCadastro 	:= "Cadastro de Riscos"
Private cPerg		:= "CAB079"
Private aRotina   	:= MenuDef()
Private	aCores 		:= 	{ 	{ "PBQ->PBQ_RISCO == '3'"		, 'BR_VERMELHO'	},;
                      		{ "PBQ->PBQ_RISCO == '2'"		, 'BR_AMARELO' 	},;
                      		{ "PBQ->PBQ_RISCO == '1'"		, 'BR_VERDE'	},;							
							{ "!(PBQ->PBQ_RISCO $ '1,2,3')"	, 'BR_CINZA'	}}
DbSelectArea('PBQ')
DbSetOrder(1)
DbgoTop()

PBQ->(mBrowse(06,01,22,75,'PBQ',,,,,,aCores,,,,, .T. ))

Return

*************************************************************************************************************************

Static Function MenuDef()  

Local aRotina := {	{ 'Pesquisar'	,'AxPesqui'		, 0 , 1 , 0, .F.},; 
					{ 'Visualizar'	,'AxVisual'		, 0 , 2 , 0, Nil},; 
					{ 'Incluir'		,'AxInclui'		, 0 , 3 , 0, Nil},; 
					{ 'Alterar'		,'AxAltera'		, 0 , 4 , 0, Nil},; 
					{ 'Excluir'		,'AxDeleta'		, 0 , 5 , 0, Nil},;
					{ 'Marcacao'	,'U_CAB079SP'	, 0 , 3 , 0, Nil},;
					{ 'Legenda'		,'U_CAB079LEG'	, 0 , 2 , 0, .F.} }
Return aRotina

*************************************************************************************************************************

User Function CAB079LEG
                       
BrwLegenda(cCadastro, "Legenda", {	{"BR_VERMELHO"	, "Alto Risco"			},;
									{"BR_AMARELO"	, "Médio Risco"			},;
									{"BR_VERDE"		, "Baixo Risco"   		},;
									{"BR_CINZA"		, "Risco Indefinido"	}})

Return

*************************************************************************************************************************

//chama a procedure que faz a carga da tabela PBQ
User Function CAB079SP
     
Local cSP := ""  
Local cNupDe := ""  
Local cNupAte := ""   
Local cMatDe := ""
Local cMatAte := ""   
Local cRisDe := ""  
Local cRisAte := ""         

If MsgYesNo("Esta Rotina refaz a Classificacao de Risco conforma parametrizacao, confirma execucao ?",AllTrim(SM0->M0_NOMECOM))	
	AjustaSX1()
	
	If Pergunte(cPerg,.T.)  		
		
		cNupDe  := AllTrim(Str(mv_par01))  
	  	cNupAte := AllTrim(Str(mv_par02))  
	  	cMatDe 	:= mv_par03
	  	cMatAte := mv_par04  
	  	cRisDe 	:= AllTrim(Str(mv_par05)) 
	  	cRisAte := AllTrim(Str(mv_par06))  
	  		     
	    cSP := "BEGIN "  
		cSP += "  GRAVA_RISCO_PROTOCOLO('" + cNupDe + "','" + cNupAte + "','" + cMatDe + "','" + cMatAte + "','" + cRisDe + "','" + cRisAte + "'); "     
		cSP += "END;"            
		
		Processa({||CAB079P(cSP)},'Processando...')   
		
		GetDRefresh()
		DbgoTop()
		
	EndIf    
Endif	                                                                   

Return   

*************************************************************************************************************************

Static Function CAB079P(cSP)    

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua(0)
	
For i:= 1 to 5
	Incproc(' - Iniciando Marcacao...')
Next         

//Memowrit( "C:\CABA079a.sql", cSP)

If TcSqlExec(cSP) < 0
	MsgStop("Erro " + TCSQLError(),AllTrim(SM0->M0_NOMECOM))
EndIf

Return

*************************************************************************************************************************

//busca nome do assistido
User Function CAB079G

Local cRet 	:= Space(TamSX3('PBQ_NOME')[1])
Local aArea	:= BA1->(GetArea())

BA1->(DbSetOrder(2))

If BA1->(MsSeek(xFilial('PBQ') + PBQ_CODINT + PBQ_CODEMP + PBQ_MATRIC + PBQ_TIPREG + PBQ_DIGITO)) 
	cRet := BA1->BA1_NOMUSR 
EndIf

BA1->(RestArea(aArea))

Return cRet                           

*************************************************************************************************************************

Static Function AjustaSX1

PutSx1(cPerg,"01","NUPRE de    "  ,"","","mv_ch01","N",01,0,0,"C","","","","","mv_par01","1-Niteroi","","","","2-Tijuca","","","3-Bangu","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","NUPRE ate   "  ,"","","mv_ch02","N",01,0,0,"C","","","","","mv_par02","1-Niteroi","","","","2-Tijuca","","","3-Bangu","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Matricula de"  ,"","","mv_ch03","C",17,0,0,"G","","B92PLS","","","mv_par03","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"04","Matricula ate" ,"","","mv_ch04","C",17,0,0,"G","","B92PLS","","","mv_par04","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )  
PutSx1(cPerg,"05","Risco de    "  ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","1-Baixo Risco","","","","2-Media Risco","","","3-Alto Risco","","","","","","","","",{},{},{})
PutSx1(cPerg,"06","Risco ate   "  ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","1-Baixo Risco","","","","2-Media Risco","","","3-Alto Risco","","","","","","","","",{},{},{})

Return  

*************************************************************************************************************************
//valida se nao existe registro ativo para o beneficiario
User Function CAB079VAL 

Local lRet 		:= .T.
Local cSql 		:= ""   
Local nRec 		:= 0 
Local cAlias	:= GetNextAlias()
Local aArea		:= GetArea()

If Inclui   
  nRec := 0 
Else  
  nRec := PBQ->(RECNO())
Endif  

If (Inclui .OR. (Altera .AND. Empty(M->PBQ_DATVIG))) //incluino ou reativando

	cSQL := " SELECT SIGN(COUNT(R_E_C_N_O_)) QTD "
	cSQL += " FROM " + RetSQLName("PBQ") + " PBQ " 
	cSQL += " WHERE  PBQ_FILIAL =  '" + xFilial("PBQ") + "' "
	cSQL += " AND    PBQ_CODINT =  '" + M->PBQ_CODINT + "' "
	cSQL += " AND    PBQ_CODEMP =  '" + M->PBQ_CODEMP + "' "
	cSQL += " AND    PBQ_MATRIC =  '" + M->PBQ_MATRIC + "' "
	cSQL += " AND    PBQ_TIPREG =  '" + M->PBQ_TIPREG + "' "
	cSQL += " AND    PBQ_DIGITO =  '" + M->PBQ_DIGITO + "' "  
	cSQL += " AND    R_E_C_N_O_ <>  " + AllTrim(Str(nRec)) + " "  //garantir registro diferente
	cSQL += " AND    PBQ_DATVIG = ' ' "   
	cSQL += " AND    D_E_L_E_T_ = ' ' " 
	
	TcQuery cSQL New Alias cAlias
	
	If cAlias->QTD > 0
	  lRet := .F.     
	  MsgStop("Existe uma outra Classificacao de Risco ativa para esta Matricula, encerre-a antes fazer esta operacao.",AllTrim(SM0->M0_NOMECOM)) 
	EndIf
			
	cAlias->(DbCloseArea())		
	
EndIf	
	
RestArea(aArea)

Return lRet

*************************************************************************************************************************

//busca nupre do assistido
User Function CAB079NP(cCODINT,cCODEMP,cMATRIC,cTIPREG)   

Local lRet 		:= .F.           
Local cData 	:= DToS(dDataBase)      
Local cSQL 		:= " " 
Local cAlias	:= GetNextAlias()
Local aArea		:= GetArea()

cSQL := " SELECT  RETORNA_NUCLEO_MS('" + cCODINT + "','" + cCODEMP + "','" + cMATRIC + "','" + cTIPREG + "','" + cData + "') NUPRE "
cSQL += " FROM DUAL "    
	       
TcQuery cSql New Alias cAlias
			
If Empty(cAlias->NUPRE)
  lRet := .F.     
  MsgStop("Matricula nao vinculada a nenhum NUPRE.",AllTrim(SM0->M0_NOMECOM)) 
Else    
  lRet := .T.   
EndIf
		
cAlias->(DbCloseArea())	

RestArea(aArea)

Return lRet 