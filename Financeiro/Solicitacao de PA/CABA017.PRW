#INCLUDE "rwmake.ch"
#Include 'TOPCONN.CH' 
#include 'protheus.ch'


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA017   º Autor ³ Marcela Coimbra    º Data ³  07/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA017

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

Private cCadastro	:= "Aprovação de Solicitação de PA"
Private cDelFunc 	:= ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cString 	:= "SCR"
Private cFiltraSCR 	:= ""    

Private a_SaldoPls  := {}         
Private a_VetSe2  	:= {}  

Private aCores 		:={ { 'CR_STATUS== "01"', 'BR_AZUL' },;   //Bloqueado p/ sistema (aguardando outros niveis)
						{ 'CR_STATUS== "02"', 'DISABLE' },;   //Aguardando Liberacao do usuario
						{ 'CR_STATUS== "03"', 'ENABLE'  },;   //Pedido Liberado pelo usuario
						{ 'CR_STATUS== "04"', 'BR_PRETO'},;   //Pedido Bloqueado pelo usuario
						{ 'CR_STATUS== "05"', 'BR_CINZA'} }   //Pedido Liberado por outro usuario
				

Private aRotina 	:= {{"Pesquisar"	,"AxPesqui"		,0,1},;
             			{"Visualizar"	,"U_c17Visu"	,0,2},;
			        	{"Aprovar"		,"U_c17Aprova"	,0,6},;
			        	{"Reprovar"		,"U_c17Reprova"	,0,7},;
		            	{"Legenda"   	,"U_c17Legend"	,0,2} }

If Pergunte("MTA097",.T.)

	dbSelectArea("SCR")
	dbSetOrder(1)
	           
	cFiltraSCR  := 'CR_TIPO ="PA" .AND. (CR_USER=="' + __cUserId + '" .OR. ( CR_NIVEL > "01" .AND. "' + __cUserId +  '" $ "' + GetMv("MV_XAPROSB")
	
	Do Case
		Case mv_par01 == 1
			cFiltraSCR += '") ) .And.CR_STATUS=="02"'
		Case mv_par01 == 2
			cFiltraSCR += '") ) .And.(CR_STATUS=="03".OR.CR_STATUS=="05")'
		Case mv_par01 == 3
			cFiltraSCR += '") ) '
		OtherWise
			cFiltraSCR += '") ) .And.(CR_STATUS=="01".OR.CR_STATUS=="04")'
	EndCase
	
	SCR->( DBSetOrder(1) )
	DbSelectArea("SCR")
	SET FILTER TO &( cFiltraSCR )
	
	dbSelectArea("SCR")
	mBrowse( 6, 1,22,75,"SCR",,,,,,aCores)  
	
	dbClearFilter()

EndIf
	
Return

**'-----------------------------------------------------------------------'**
**'--Tela de Legenda -----------------------------------------------------'**
**'-----------------------------------------------------------------------'**
User Function c17Legend()
**'-----------------------------------------------------------------------'**

BrwLegenda(cCadastro,"Legenda", { ; //Legenda
								{"BR_AZUL" , "Bloqueado (Aguardando outros niveis)"		},; 
								{"DISABLE" , "Aguardando Liberacao do usuario"			},; 
								{"ENABLE"  , "Solicitação Liberado pelo usuario"		},; 
								{"BR_PRETO", "Solicitação Bloqueado pelo usuario"		},; 
								{"BR_CINZA", "Solicitação Liberado por outro usuario" 	}}) 
							
Return(.T.)

**'-----------------------------------------------------------------------'**                                                                             
**'--Rotina para aprovação de grade---------------------------------------'**                                                                             
**'-----------------------------------------------------------------------'**
User Function c17Aprova( c_Alias, n_Recno )
**'-----------------------------------------------------------------------'**

Private c_Grade 	:= "" 
Private a_Area 		:= GetArea() 
Private a_Buttons 	:= {}
Private c_Agencia 	:= ""
Private c_Banco  	:= ""
Private c_Conta 	:= ""


If SCR->CR_DATALIB
     
	Aviso("CABERJ.", "A solicitação de Pagamento Adiantado numero " + Alltrim( SCR->CR_NUM ) + " ja se encontra liberada/reprovada. ", {"Ok"})
    Return
    
EndIf 
                       
dbClearFilter() 

dbSelectArea("PA0")
dbSetOrder(1)
If dbseek( xFilial("PA0") + SCR->CR_NUM )                  

	aAdd( a_Buttons, { "BUDGET",{|| u_c19Posic("SCR", n_Recno, 3) }, "Visualisa aprovações", "Vis. Aprocação " } )       

	n_Opc := u_VisuAprov( n_Recno, .T., u_fPosSAL(PA0->PA0_GRUPO, __cUserId , .T. ))
	   
	If n_Opc == 1  
	
		c_Grade := PA0->PA0_GRUPO  
		
		l_Libera := u_fAltGrade({SCR->CR_NUM,"PA",SCR->CR_VALLIB,__cUserId,,c_Grade,,1,,dDataBase},dDataBase,4)// Cria grade   
			
		dbSelectArea("SCR")
	
		If l_Libera
		    
			Begin Transaction
				                             
				If !Empty(c_Banco + c_Agencia + c_Conta) 
				
					a_Banco :=  { c_Banco , c_Agencia , c_Conta}
				
					c_Ret := u_GeraSe2( SCR->CR_YDTPGTO, a_Banco)
				
				Else                                 
				
					a_Banco := &(GetMv("MV_XBCOPA"))	        
					
					c_Ret := u_GeraSe2( SCR->CR_YDTPGTO, a_Banco )
				
				EndIf 
				
				
				If !Empty( c_Ret )
		
					DisarmTransaction()
					SCR->( DBSetOrder(1) )
					DbSelectArea("SCR")
					SET FILTER TO &( cFiltraSCR )
		
				  u_fAvisaSPA('1', Alltrim(SCR->CR_NUM), __cUserId )
					
					Return
	
				EndIf
						
				Reclock("PA0", .F.)    
				
					PA0->PA0_DTCANC   	:= DATE()
					PA0->PA0_STATUS 	:= "A"
					PA0->PA0_BANCO 		:= a_Banco[1]
					PA0->PA0_AGENCIA 	:= a_Banco[2]
					PA0->PA0_CONTA 		:= a_Banco[3]  
					PA0->PA0_PAGREA		:= SCR->CR_YDTPGTO
					
				MsUnlock() 
	
			  u_fAvisaSPA('1', Alltrim(SCR->CR_NUM), __cUserId )
			
			End Transaction
	
		Else
		
			Reclock("PA0", .F.)    
	
				PA0->PA0_PAGREA		:= SCR->CR_YDTPGTO
	
			MsUnlock() 
	
			
			u_cb19SE2Sal( PA0->PA0_FORNEC )
			// u_cb19GSaldo(PA0->PA0_RDA, PA0->PA0_PERINI, PA0->PA0_PERFIN ) 
	    
	    	u_016WFApro( a_SaldoPls,  a_VetSe2 , PA0->PA0_NUM, c_Grade )
			
		EndIf
	
	EndIf 

Else

	Alert("SPA não encontrada.")	 
	
EndIf
  

SCR->( DBSetOrder(1) )
DbSelectArea("SCR")
SET FILTER TO &( cFiltraSCR )

Return            

**'-----------------------------------------------------------------------'**                                                                             
**'--Rotina para geração de SE2-------------------------------------------'**                                                                             
**'-----------------------------------------------------------------------'**
User Function GeraSe2( d_DataEmis, a_Banco )

Local l_Ret 	:= .f.    
Local xFornece 	:= " "
Local a_DadosSE2:= {} 
Local _cErro 	:= ""

default d_DataEmis 	:= "" 
default a_Banco 	:= &(GetMv("MV_XBCOPA")) 
//default d_DataEmis = dDataBase

dbselectarea("BAU")
dbsetorder(1)
If dbseek(xFilial("BAU")+PA0->PA0_RDA)
	xFornece := BAU->BAU_CODSA2
Else
	
	Alert("Fornecedor nao cadastrado para o RDA.")
	Return "Fornecedor nao cadastrado para o RDA."

Endif   

dbselectArea("SE2")
dbSetOrder(1)
If dbSeek("01SPA"+alltrim( PA0->PA0_NUM ))

c:= "1"

Else

	d_Emis := DataValida( iif( !Empty( d_DataEmis ), d_DataEmis , PA0->PA0_PAGSUG ))	
	
	d_DataAnt := dDataBase
	dDataBase := d_Emis
                                                                        
	aadd(a_DadosSE2, {'E2_PREFIXO'	, "SPA"  			, NIL})
	aadd(a_DadosSE2, {'E2_NUM'		, PA0->PA0_NUM 		, NIL})
	aadd(a_DadosSE2, {'E2_PARCELA'	, " " 				, NIL})
	aadd(a_DadosSE2, {'E2_TIPO'   	, "PA"				, NIL})
	aadd(a_DadosSE2, {'E2_FORNECE'	, xFornece 			, NIL})
	aadd(a_DadosSE2, {'AUTBANCO'	, a_Banco[1]		, NIL})
	aadd(a_DadosSE2, {'AUTAGENCIA'	, a_Banco[2] 		, NIL})
	aadd(a_DadosSE2, {'AUTCONTA'	, a_Banco[3] 		, NIL})
	aadd(a_DadosSE2, {'E2_LOJA'   	, '01'  	, NIL})
	aadd(a_DadosSE2, {'E2_NATUREZ'	, PA0->PA0_NATUREZ 	, NIL})
	aadd(a_DadosSE2, {'E2_EMISSAO'	, d_Emis 			, NIL})
	aadd(a_DadosSE2, {'E2_VENCTO' 	, d_Emis 			, NIL})
	aadd(a_DadosSE2, {'E2_VENCREA'	, d_Emis 			, NIL})
	//aadd(a_DadosSE2, {'E2_HIST'   	, "INCLUSAO AUTOMATICA" , NIL})
	aadd(a_DadosSE2, {'E2_HIST'   	, iIf(PA0->PA0_TPTITU=="6","ADIANTAMENTO A CONVENIADO","ADIANTAMENTO A CREDENCIADO") , NIL})
	aadd(a_DadosSE2, {'E2_VALOR'  	, PA0->PA0_VALOR	, NIL})
	aadd(a_DadosSE2, {'E2_VLCRUZ'  	, PA0->PA0_VALOR	, NIL})
	aadd(a_DadosSE2, {'E2_CCD'  	, PA0->PA0_CC		, NIL})
	aadd(a_DadosSE2, {'E2_YMECPPA' 	, PA0->PA0_MESCOM   , NIL})     
	aadd(a_DadosSE2, {'E2_YANCPPA' 	, PA0->PA0_ANOCOM	, NIL})       
	
	//Tratando o "Pergunte"  Alterado por Renato e Motta em 06/01/12
    
   /* nPar5 := 0
    
    dbselectArea("SX1")
    dbSetOrder(1)
    If DbSeek("FIN050    05")
    	nPar5 := SX1->X1_PRESEL
    EndIf
    
    If nPar5 <> 2
    	SX1->X1_PRESEL := 2
    EndIf */
	
	BEGIN Transaction
    QOut(iIf(PA0->PA0_TPTITU=="6","ADIANTAMENTO A CONVENIADO","ADIANTAMENTO A CREDENCIADO"))
	_lRet		:= .T.
	lMsErroAuto := .F.
	MSExecAuto({|x,y,z| Fina050(x,y,z)},a_DadosSE2,,3)
	
	dDataBase := d_DataAnt 
	
	IF lMsErroAuto 
		QOut( "E R R O    N O    E X E C A U T O"	)

		lMsHelpAuto := .T.
		DisarmTransaction()
		_cErro := MostraErro(NIL, "C:\erro_exec.GER") // Para gravar o erro
		memowrite("C:\erro_exec.GER", _cErro)

		QOut( _cErro	)

		_lRet	:= .F.
  
	ENDIF
	
	
	END Transaction
	
	//Retorno o conteudo original do X1 na pergunta do FIN050
	//Tratando o "Pergunte"
    dbselectArea("SX1")
    dbSetOrder(1)
    If DbSeek("FIN05005")
    	SX1->X1_PRESEL := nPar5
    EndIf
    //Fim alteração Renato e Motta. 06/01/12
    
	DbCommitAll()

EndIf

Return _cErro
      
**'-----------------------------------------------------------------------'**
**'--Tela de Legenda -----------------------------------------------------'**
**'-----------------------------------------------------------------------'**
User Function c17Visu(c_alias, n_Recno)
**'-----------------------------------------------------------------------'**

Private a_Area 	:= GetArea() 
Private a_Buttons := {}
                       
dbClearFilter() 

dbSelectArea("PA0")
dbSetOrder(1)
dbseek( xFilial("PA0") + SCR->CR_NUM )                  

aAdd( a_Buttons, { "BUDGET",{|| u_c19Posic("SCR", n_Recno, 3) }, "Visualisa aprovações", "Vis. Aprocação " } )       
//aAdd( a_Buttons, { "RELATORIO",{|| u_c19PoRDA("PA0", PA0->( RECNO() ), 2) }, "Visualisa Status RDA", "Vis. RDA " } )

n_Opc := u_VisuAprov( n_Recno, .T., .F., .F. )

SCR->( DBSetOrder(1) )
DbSelectArea("SCR")
SET FILTER TO &( cFiltraSCR )

Return            


**'-----------------------------------------------------------------------'**                                                                             
**'--Rotina para aprovação de grade---------------------------------------'**                                                                             
**'-----------------------------------------------------------------------'**
User Function c17Reprova(c_Alias, nReg )                             
**'-----------------------------------------------------------------------'**

Private c_Grade 	:= "" 
Private a_Area 	:= GetArea() 
Private a_Buttons := {} 

If SCR->CR_DATALIB
     
	Aviso("CABERJ.", "A solicitação de Pagamento Adiantado numero " + alltrim( SCR->CR_NUM ) + " ja se encontra liberada/reprovada. ", {"Ok"})
    Return
    
EndIf 

                       
dbClearFilter()         

dbSelectArea("PA0")
dbSetOrder(1)
If dbseek( xFilial("PA0") + SCR->CR_NUM )
	
	c_TpAprov := u_fTpAprov( )                    
	
	If c_TpAprov == "A"
	
		aAdd( a_Buttons, { "BUDGET",{|| u_c19Posic("SCR", nReg, 3) }, "Visualisa aprovações", "Vis. Aprocação " } )       
	//	aAdd( a_Buttons, { "RELATORIO",		{|| u_c19PoRDA("PA0", nReg, 2) }, "Visualisa Status RDA", "Vis. RDA " 		} )
		
		//	n_Opc := AxVisual("PA0", PA0->(Recno()),2)     
		n_Opc := u_VisuAprov( SCR->( RECNO() ), .F., .F., .F.)
		     
		If n_Opc == 1
		    
			l_Libera := u_fAltGrade({SCR->CR_NUM,"PA",SCR->CR_VALLIB,__cUserId,,PA0->PA0_GRADE,,1,,dDataBase},dDataBase,6)// Cria grade   
			
			SCR->( DBSetOrder(1) )
			DbSelectArea("SCR")
			SET FILTER TO &( cFiltraSCR )
				
			dbSelectArea("SCR")
			
			dbSelectArea("PA0")
							
			Reclock("PA0", .F.)
				PA0->PA0_DTCANC   	:= DATE()
				PA0->PA0_STATUS 	:= "R"
			MsUnlock()
		
		   u_fAvisaSPA('4', Alltrim(SCR->CR_NUM), __cUserId )
			
		EndIf
			
	Else
	
		Aviso("CABERJ - Usuário não esta autorizado.", "O usuário esta cadastrado como vistador para essa solicitação, portanto não poderá reprová-la. ", {"Ok"})
	
	EndIf

Else 

	Alert("SPA não encontrada.")

EndIf
SCR->( DBSetOrder(1) )
DbSelectArea("SCR")
SET FILTER TO &( cFiltraSCR )

Return            



User Function fTpAprov( c_Usuario )  

Local c_Qry := " " 
Local c_Ret := " "               

DEFAULT c_Usuario := __cUserId
                  
                  
c_Qry += " SELECT AL_LIBAPR "
c_Qry += " FROM  " + RETSQLNAME("SAL") + " SAL,  " + RETSQLNAME("SAK") + " SAK "
c_Qry += " WHERE AL_FILIAL 		= '" + XFILIAL("SAL")+ "' "
c_Qry += " 		 AND AK_FILIAL	= '" + XFILIAL("SAK")+ "' " 
c_Qry += " 		 AND AL_USER   	= AK_USER "
c_Qry += " 		 AND AL_USER   	= '" + c_Usuario 	 + "' "
c_Qry += " 		 AND SAL.D_E_L_E_T_ <> '*' "
c_Qry += " 		 AND SAK.D_E_L_E_T_ <> '*' "

TcQuery c_Qry New Alias "QRYSAL"
                         
If !QRYSAL->( EOF() )

	c_Ret := QRYSAL->AL_LIBAPR

EndIf                    

QRYSAL->( dbCloseArea() )

Return c_Ret


User Function VisuAprov( n_CrRecno, l_Aprova, l_When, l_When2 )                        

Local c_Ano 	:= PA0->PA0_ANOCOM
Local c_Cc 		:= PA0->PA0_CC    
Local d_DtInc 	:= PA0->PA0_DTINC 
Local d_DtNPgto := PA0->PA0_PAGREA
Local d_DtPgtoS := PA0->PA0_PAGSUG
Local c_Mes 	:= PA0->PA0_MESCOM
Local c_Nature 	:= PA0->PA0_NATURE
Local c_NJust 	:= space(250)                                                                               
Local c_Nome 	:= PA0->PA0_NOME  
Local c_Numero 	:= PA0->PA0_NUM   
Local c_Rda 	:= PA0->PA0_RDA   
Local n_Perc 	:= PA0->PA0_PERC  
Local n_Val 	:= PA0->PA0_VALOR 
Local n_ValPro 	:= PA0->PA0_VLPROT 
Local c_Obs		:= PA0->PA0_JUSTIF   
Local a_Banco 	:= &(GetMv("MV_XBCOPA")) 

Local o_Ano 	
Local o_Cc 		
Local o_DtInc 	
Local o_DtNPgto 
Local o_DtPgtoS 
Local o_Mes 	
Local o_Nature 	
Local o_NJust 	
Local o_Nome 	
Local o_Numero 	
Local o_Rda 	
Local o_Perc 	
Local o_Val 	
Local o_ValPro 	
Local o_Obs                                          
Local c_Opc := 0
Local o_Agencia 
Local o_Banco  	
Local o_Conta 	

Local oGroup1
Local oGroup2
Local oSay1
Local oSay10
Local oSay11
Local oSay12
Local oSay13
Local oSay14
Local oSay15
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6
Local oSay7
Local oSay8
Local oSay9

c_Agencia 	:= a_Banco[2] + space(tamsx3("A6_AGENCIA")[1] 	- len( a_Banco[2] ) ) 
c_Banco  	:= a_Banco[1] + space(tamsx3("A6_COD")[1] 		- len( a_Banco[1] ) ) 
c_Conta 	:= a_Banco[3] + space(tamsx3("A6_NUMCON")[1] 	- len( a_Banco[3] ) ) 

Static oDlg

  	DEFINE MSDIALOG oDlg FROM 0,0 TO 600,600 TITLE OemToAnsi("Liberacao do SPA") PIXEL  //"Liberacao do PC"

    @ 026, 006 GROUP oGroup1 TO 191, 291 OF oDlg COLOR 0, 12632256 PIXEL
    @ 037, 012 SAY oSay1  PROMPT "Numero"             SIZE 025, 007 OF oDlg COLORS 0, 12632256 PIXEL      
        
    @ 037, 155 SAY oSay2  PROMPT "RDA"                SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 052, 012 SAY oSay3  PROMPT "Nome RDA"           SIZE 031, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 052, 155 SAY oSay4  PROMPT "Inclusão"           SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 067, 012 SAY oSay5  PROMPT "Valor Protocolo"    SIZE 049, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 067, 155 SAY oSay6  PROMPT "Percentual"         SIZE 029, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 082, 012 SAY oSay7  PROMPT "Valor a Pagar"      SIZE 040, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 082, 155 SAY oSay8  PROMPT "Pagamento Sugerido" SIZE 058, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 097, 012 SAY oSay9  PROMPT "Centro de Custo"    SIZE 042, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 097, 155 SAY oSay10 PROMPT "Natureza"           SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 112, 012 SAY oSay11 PROMPT "Mes Compensação"    SIZE 052, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 112, 155 SAY oSay12 PROMPT "Ano Compensação"    SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 127, 012 SAY oSay13 PROMPT "Justificativa"      SIZE 031, 007 OF oDlg COLORS 0, 16777215 PIXEL

    @ 036, 061 MSGET o_Numero  VAR c_Numero  When .F. SIZE 060, 010 OF oDlg PIXEL
  //  @ 101,115  MSGET oSaldif   VAR nSalDif Picture "@E 999,999,999.99" When .F. SIZE 85,9 OF oDlg PIXEL RIGHT

    @ 050, 061 MSGET o_Nome    VAR c_Nome    When .F. SIZE 087, 010 OF oDlg  PIXEL
    @ 065, 061 MSGET o_ValPro  VAR n_ValPro  Picture "@E 999,999,999.99" When .F. SIZE 060, 010 OF oDlg  PIXEL
    @ 081, 061 MSGET o_Val     VAR n_Val     Picture "@E 999,999,999.99" When .F. SIZE 060, 010 OF oDlg  PIXEL
    @ 095, 062 MSGET o_Cc      VAR c_Cc      SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 110, 062 MSGET o_Mes     VAR c_Mes     SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 036, 210 MSGET o_Rda     VAR c_Rda     SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 051, 210 MSGET o_DtInc   VAR d_DtInc   SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 065, 210 MSGET o_Perc    VAR n_Perc    Picture "@E 999,999,999.99" SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 079, 210 MSGET o_DtPgtoS VAR d_DtPgtoS SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 094, 210 MSGET o_Nature  VAR c_Nature  SIZE 060, 010 OF oDlg  When .F. PIXEL
    @ 110, 210 MSGET o_Ano     VAR c_Ano     SIZE 060, 010 OF oDlg  When .F. PIXEL                     
    
    @ 129, 062 GET o_Obs       VAR c_Obs     MEMO SIZE 209, 053 OF oDlg  When .F. PIXEL
   
    @ 198, 008 GROUP oGroup2 TO 279, 293 OF oDlg COLOR 0, 16777215 PIXEL
    @ 211, 012 SAY oSay14 PROMPT "Data para Pgto" SIZE 040, 007 OF oDlg COLORS 0, 16777215  PIXEL
    @ 210, 061 MSGET o_DtNPgto VAR d_DtNPgto SIZE 060, 010 OF oDlg  When l_When PIXEL
   
  	@ 228, 013 SAY oSay16 PROMPT "Banco" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 227, 061 MSGET o_Banco VAR c_Banco SIZE 031, 010 OF oDlg  F3 "SA6" When l_When PIXEL
    @ 228, 099 SAY Agencia PROMPT "Agencia" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 227, 124 MSGET o_Agencia VAR c_Agencia  SIZE 051, 010 OF oDlg  When l_When PIXEL
    @ 227, 209 MSGET o_Conta VAR c_Conta SIZE 060, 010 OF oDlg  When l_When PIXEL
    @ 228, 187 SAY oSay17 PROMPT "Conta" SIZE 019, 007 OF oDlg COLORS 0, 16777215 PIXEL

    @ 243, 061 GET o_NJust VAR c_NJust  MEMO SIZE 210, 033 OF oDlg COLORS 0, 16777215 When l_When2 PIXEL
    @ 245, 013 SAY oSay15 PROMPT "Justificativa" SIZE 038, 007 OF oDlg COLORS 0, 16777215 PIXEL 
      
    EnchoiceBar(oDlg, {|| c_Opc:= 1, oDlg:End()}, {||c_Opc:= 2, oDlg:End()},,a_Buttons ) 

  ACTIVATE MSDIALOG oDlg CENTERED    
                       
If l_Aprova .and.  c_Opc == 1
            
	dbSelectArea("SCR")
	dbGoto( n_CrRecno )  
		
	Reclock("SCR", .F.)
	
		SCR->CR_YOBS2   	:= c_NJust
		SCR->CR_YDTPGTO   	:= d_DtNPgto
		SCR->CR_WF   		:= "N" 
		SCR->CR_YBANCO 		:= c_Banco + c_Agencia + c_Conta
		
	MsUnlock()                   

EndIf

Return c_Opc
