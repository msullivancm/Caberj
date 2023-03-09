#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TopConn.Ch"
#INCLUDE "FONT.CH"      


#DEFINE c_ent CHR(13) + CHR(10)
/*                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍmarcela.ÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³COMPFAI   ºAutor  ³Microsiga           º Data ³  07/13/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Compatibiliza faixa de cobrança                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function COMPFAI()
                        
Local cPerg	       		:= "COMPFAI"

Private cComboBx1                                        
Private cTitRotina 		:= "Ajuste de tabelas de cobrança"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 		:= {}

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE "Ajuste de tabelas de cobrança" FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                                        *
*Comando para selecionar um arquivo.                                                                                            *
*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                                     *
*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                                         *
*-----------------------------------------------------------------------------------------------------------------* 

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,GETF_LOCALHARD))
@ 045,009 Say  "Delimitador"      Size 045,008 PIXEL OF oDlg   

aCombo := {"Somente relatorio","Executar atualização"}  
cCombo := space(1)      

@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,10 PIXEL OF oDlg

*-----------------------------------------------------------------------------------------------------------------*
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

c_Separador := ';'

If _nOpc == 1
	
	Processa({COMPFAIA()},"Importando Profissionais de Saude...")
	
Endif

Return

*------------------------------------------------------------------*
Static Function COMPFAIA()
*------------------------------------------------------------------*
* função para importar o arquivo                                          
*------------------------------------------------------------------*

Local c_Arq		:= c_dirimp
Local n_Lin   	:= 0
Local c_Qry    	:= ""
Local n_QtdLin	:= 0           
Private A_ERRO := {}

IF !Empty(c_Arq)

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	Alert("Informe o Arquivo a ser importado!")

Endif     

n_QtdLin := FT_FLASTREC()
c_QtdLin := allTrim(Transform( n_QtdLin,'@E 999,999,999'))   



ProcRegua( n_QtdLin )

n_QtdLin := 0

FT_FSKIP() //o primeiro registro pode ser avançado, pois contém somente os nomes das colunas
	
aDados := {}
	
While !FT_FEOF()
	
	IncProc('Processando linha ' + allTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

	c_Buffer   := FT_FREADLN()
	n_Loop     := 0
		
	x_Pos := AT( c_Separador, c_Buffer)
                                                   
	a_TmpDados := {}
	aAdd (a_TmpDados , {"","","","","","",""} )

	While x_Pos <> 0 
	
		n_Loop++
		a_Info    				:= AllTrim(SubStr(c_Buffer , 1, x_Pos-1 ))
		a_TmpDados[1][n_Loop] 	:= a_Info
		c_Buffer				:= SubStr(c_Buffer , x_Pos+1, Len(c_Buffer)-x_Pos)
		x_Pos 					:= AT(c_Separador,c_Buffer) 
		
		If  n_Loop == 7
		     
			Exit
		
		EndIf
		
	Enddo

    //FBKPBYB() // Faixas Etarias Usr x Reajustes
    //FBKPBP7() // Faixas das Familias Reajustes 
    
    u_FAJUSTFAM( a_TmpDados , @A_ERRO)
    

	FT_FSKIP()
		
Enddo

FT_FUSE()

	alert("Fim")
	
	If Len(A_ERRO) > 0                                                                       
	
		PLSCRIGEN(A_ERRO,{ {"Tabela","@C",3},{"Matricula","@C",17},{"Críticas encontradas!","@C",200}},"Críticas encontradas!",.T.)		
		_aErrAnlt := {}  
		
	EndIf



Return      

User Function FAJUSTFAM( a_Dado, A_ERRO )
	
	// MES_ANO_REF	||	NOMEPLANO		|| CODPLA	|| NOME						|| MAT					|| MESREA	|| MENSA_COB
	// 01/06/2012	||  AFINIDADE I		|| 0006		|| IRENE RODRIGUES DA SILVA	|| 00010005008250001	|| 07		|| 698,28

	Local c_Qry 	:= " "     
	Local l_Erro	:= .F.               
	Local c_MatFam 	:= substr(a_Dado[1][5], 1, 14 ) 
	Local c_MatUsu 	:= a_Dado[1][5]       
	Local c_Plano	:= a_Dado[1][3]
	                                    
	
	
	dbSelectArea("BA3")
	dbSetOrder(1)   
	If dbSeek( xFilial("BA3") + c_MatFam ) 
		
		If BA3->BA3_CODPLA == c_Plano 
		
	     	fAtuFamilia(c_MatFam, , @A_ERRO )
		
		Else
		
			AADD(A_ERRO, {"BA3", C_MATUSU, "PLANO DA FAMILIA DIFERE DA PLANILHA" } )
		
		EndIf
		
	Else
		// excessao do historico da familia
	EndIf                        
	  
	dbSelectArea("BA1")
	dbSetOrder(2)   
	If dbSeek( xFilial("BA1") + c_MatUsu )

			fAtuUsuario( SUBSTR( c_MatUsu, 1,16  ), @A_ERRO	)
				                                       
	Else      
		
		     AADD(A_ERRO, {"BA1", C_MATUSU, "PLANO DA FAMILIA DIFERE DA PLANILHA" } )
		     
	EndIf    
	

        
Return   

//  

Static function fAtuFamilia( C_MATFAM )   

Local nCnt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local n_VlrAtu  := 0
Local c_FaiCob  := ""			
Local idade		:= ""

  
	  		**'PONTERA NA TABELA DA FAMILIA------------------------------------------------------------------- PONTERA NA TABELA DA FAMILIA'**        
			BBU->(DBSETORDER(1))
			IF BBU->(DBSEEK(XFILIAL("BBU")+C_MATFAM)) 
			 	
			    **'LOOP NA BBU PARA PEGAR VALOREA ATUAIS E SALVAR HISTÓRICO'** 
				WHILE !BBU->( EOF() ) .AND. BBU->(BBU_FILIAL+BBU_CODOPE+BBU_CODEMP+BBU_MATRIC) == XFILIAL("BBU")+C_MATFAM
                                                             

					**'GRAVA HISTORICO DA FAMíLIA--------------------------------------------------------------------- GRAVA HISTóRICO DA FAMíLIA'** 
					     
					    
					   	BP7->(RECLOCK("BP7",.T.))    
						
							BP7->BP7_FILIAL := XFILIAL("BP7")
							BP7->BP7_OPEREA := "0001"
							BP7->BP7_CODREA := "666666"
							//	BP7->BP7_CODAJS := CCODAJS
							BP7->BP7_CODOPE := BA3->BA3_CODINT
							BP7->BP7_CODEMP := BA3->BA3_CODEMP
							BP7->BP7_MATRIC := BA3->BA3_MATRIC
							BP7->BP7_CODFAI := BBU->BBU_CODFAI
							BP7->BP7_IDAINI := BBU->BBU_IDAINI
							BP7->BP7_IDAFIN := BBU->BBU_IDAFIN
							BP7->BP7_VLRANT := BBU->BBU_VALFAI
							BP7->BP7_VLRREA := 999//NVLRREA
							BP7->BP7_DATREA := DDATABASE
							BP7->BP7_INDREA := "666666"
							BP7->BP7_PERREA := 9.99
							BP7->BP7_CODFOR := BBU->BBU_CODFOR
						   
						BP7->(MSUNLOCK())     
			            
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ ESCREVO '99' NA FILIAL PARA FINS DE CONTROLE                             ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
				   /*		BBU->(RECLOCK("BBU",.F.))

							BBU->BBU_FILIAL := "99"
							
						BBU->(MSUNLOCK())
                   */

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ DELETO O REGISTRO NA TABELA DO USUÁRIO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						BBU->(RECLOCK("BBU",.F.))
							
							BBU->( DBDELETE() )
							
						BBU->(MSUNLOCK())  
						
						L_BKPBBU := .T.
						
						BA3->( RECLOCK("BA3", .F.) )	
			 
						   //	BA3->BA3_INDREA := '666666'   
							BA3->BA3_YDTENQ := dDataBase
				
						BA3->(MSUNLOCK()) 
	       
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ ATUALIZA O VALOR EM CADA FAIXA ETARIA DA FAMILIA...                      ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ ACESSA PROXIMO REGISTRO...                                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BBU->(DBSKIP())
				
				ENDDO 
				
				  
				
			   
			
			ELSE
			
				AADD(A_ERRO, {"BBU", C_MATFAM, "NÃO ENCONTRADA TABELA DE FAMILIA"} )
				L_BKPBBU := .F.
							
			ENDIF   
				
	**'---------------------------------------------------------------------------------------------FIM DO HISTóRICO'** 
				
	IF L_BKPBBU
		
		L_BKPBBU := .F.
		
		C_QRY := "SELECT * FROM " + RETSQLNAME("BTN")+" WHERE "
		C_QRY += "BTN_FILIAL = '"+XFILIAL("BTN")+"' AND "
		C_QRY += "BTN_CODIGO = '"+'0001' + BA3->BA3_CODEMP+"' AND "
		C_QRY += "BTN_NUMCON = '"+BA3->BA3_CONEMP+"' AND "
		C_QRY += "BTN_VERCON = '"+BA3->BA3_VERCON+"' AND "
		C_QRY += "BTN_SUBCON = '"+BA3->BA3_SUBCON+"' AND "
//		C_QRY += "BTN_SUBCON = '000000005' AND "
		C_QRY += "BTN_VERSUB = '"+BA3->BA3_VERSUB+"' AND "
		C_QRY += "BTN_CODPRO = '"+BA3->BA3_CODPLA+"' AND "
		C_QRY += "BTN_VERPRO = '"+BA3->BA3_VERSAO+"' AND "
		C_QRY += "D_E_L_E_T_ = ' ' AND BTN_TABVLD = ' ' "
		C_QRY += "ORDER BY BTN_CODFAI, BTN_TIPUSR DESC,BTN_GRAUPA DESC ,BTN_SEXO DESC"
		
		PLSQUERY(C_QRY, "TRB1")      
		
		C_FAIXA := "000"
		
		WHILE !TRB1->( EOF() )
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ TRANSFERE OS VALORES DA FORMA DE COBRANCA...                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//TRY
			
			BBU->( RECLOCK("BBU", .T.) )  
			
			C_FAIXA := SOMA1(C_FAIXA)
			FOR NCNT := 1 TO BBU->( FCOUNT() )
				CCAMPO 		:= BBU->( FIELD(NCNT) )
				
				IF CCAMPO == "BBU_CODOPE"
					BBU->( FIELDPUT(NCNT, BA3->BA3_CODINT ) )
					
				ELSEIF CCAMPO == "BBU_CODEMP"
					BBU->( FIELDPUT(NCNT, BA3->BA3_CODEMP ) )
					
				ELSEIF CCAMPO == "BBU_MATRIC"
					BBU->( FIELDPUT(NCNT, BA3->BA3_MATRIC ) )
					
				ELSEIF CCAMPO == "BBU_AUTOMA"
					BBU->( FIELDPUT(NCNT, "1") )        
					
			   ELSEIF CCAMPO == "BBU_CODFAI"
					BBU->( FIELDPUT(NCNT, C_FAIXA) )
			
					
				ELSE
					CCAMPOBTN := "TRB1->"+STRTRAN(CCAMPO, "BBU","BTN")
					IF BTN->(FIELDPOS(SUBSTR(CCAMPOBTN,7))) > 0 .AND.;
						BBU->(FIELDPOS(CCAMPO)) > 0
						
						BBU->( FIELDPUT(NCNT, &CCAMPOBTN) )
					ENDIF
				ENDIF
	
				
			
			NEXT   
		
			BBU->( MSUNLOCK() )
	       
	
	TRB1->( dbSkip() )
		
		ENDDO
		
		TRB1->( dbCloseArea() )
		
	ENDIF

Return



Static function fAtuUsuario( C_MATUSU, A_ERRO )   

Local nCnt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local c_FaiCob 	:= " "      
Local c_FaiIni 	:= " "
Local c_FaiFin 	:= " "  
Local L_BKPBDK 	:= .T.
Local n_VlrAtu  := 0
Local c_FaiCob  := ""			
Local idade		:= ""
  
	  		**'PONTERA NA TABELA DO USUARIO------------------------------------------------------------------- PONTERA NA TABELA DO USUARIO'**        
			BDK->(DBSETORDER(1))
			IF BDK->(DBSEEK(XFILIAL("BDK")+C_MATUSU)) 
			 	L_BKPBDK := .t.
			    **'LOOP NA BDK PARA PEGAR VALOREA ATUAIS E SALVAR HISTÓRICO'** 
				WHILE !BDK->( EOF() ) .AND. BDK->(BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG) == XFILIAL("BDK")+C_MATUSU
                                                                                        
					**'VERIFICA FAIXA USUÁRIO ---------------------------------------------------------------------------- VERIFICA FAIXA USUÁRIO'**
						
				   		IF BA1->BA1_MUDFAI == '0'
						     
							c_FaiCob := BA1->BA1_FAICOB  
						
						Else
						
							idade:=year(DATE())-year(BA1->BA1_DATNAS) 
							
							If idade >= BDK->BDK_IDAINI .and. idade <= BDK->BDK_IDAFIN
							     
								c_FaiCob := BDK->BDK_CODFAI

							
							EndIf
							
						EndIf  
						
						
						If !Empty(c_FaiCob) .and. c_FaiCob == BDK->BDK_CODFAI     .and. n_VlrAtu <> 0
					    
							n_VlrAtu := BDK->BDK_VALOR  
					
						EndIf
						
					  
					**'GRAVA HISTORICO DA FAMíLIA--------------------------------------------------------------------- GRAVA HISTóRICO DA FAMíLIA'** 
					    
					  	BYB->(RECLOCK("BYB",.T.))    
						
							BYB->BYB_FILIAL := XFILIAL("BYB")
							BYB->BYB_OPEREA := "0001"
							BYB->BYB_CODREA := "666666"
							//	BYB->BYB_CODAJS := CCODAJS
							BYB->BYB_CODOPE := BA1->BA1_CODINT
							BYB->BYB_CODEMP := BA1->BA1_CODEMP
							BYB->BYB_MATRIC := BA1->BA1_MATRIC 
							BYB->BYB_TIPREG := BA1->BA1_TIPREG
							BYB->BYB_CODFAI := BDK->BDK_CODFAI
							BYB->BYB_IDAINI := BDK->BDK_IDAINI
							BYB->BYB_IDAFIN := BDK->BDK_IDAFIN
							BYB->BYB_VLRANT := BDK->BDK_VALOR
							BYB->BYB_VLRREA := 999//NVLRREA
							BYB->BYB_DATREA := DDATABASE
							BYB->BYB_INDREA := "666666"
							BYB->BYB_PERREA := 9.99
						   //	BYB->BYB_CODFOR := BDK->BDK_CODFOR
						                                          
						BYB->(MSUNLOCK())    
			            
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ ESCREVO '99' NA FILIAL PARA FINS DE CONTROLE                             ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
				   /*		BDK->(RECLOCK("BDK",.F.))

							BDK->BDK_FILIAL := "99"
							
						BDK->(MSUNLOCK())
                   */

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ DELETO O REGISTRO NA TABELA DO USUÁRIO³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						
						BDK->(RECLOCK("BDK",.F.))
							
							BDK->( DBDELETE() )
							
						BDK->(MSUNLOCK())   
						
						BA1->( RECLOCK("BA1", .F.) )	
			 
						  //	BA1->BA1_INDREA := '666666'     
							BA1->BA1_YDTENQ := dDataBase
				
						BA1->(MSUNLOCK()) 
	       
						
						L_BKPBDK := .T.
						
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ ATUALIZA O VALOR EM CADA FAIXA ETARIA DO USUARIO...                      ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ ACESSA PROXIMO REGISTRO...                                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BDK->(DBSKIP())
				
				ENDDO 
				
			
			ELSE
			
				AADD(A_ERRO, {"BDK", C_MATUSU, "NÃO ENCONTRADA TABELA DE FAMILIA"} )
				L_BKPBDK := .t.
							
			ENDIF   
				
	**'---------------------------------------------------------------------------------------------FIM DO HISTóRICO'** 
				
	IF L_BKPBDK
		
		L_BKPBDK := .t.
		
		C_QRY := "SELECT * FROM " + RETSQLNAME("BTN")+" WHERE "
		C_QRY += "BTN_FILIAL = '"+XFILIAL("BTN")+"' AND "
		C_QRY += "BTN_CODIGO = '"+'0001' + BA1->BA1_CODEMP+"' AND "
		C_QRY += "BTN_NUMCON = '"+BA1->BA1_CONEMP+"' AND "
		C_QRY += "BTN_VERCON = '"+BA1->BA1_VERCON+"' AND "
//		C_QRY += "BTN_SUBCON = '000000005' AND "
		C_QRY += "BTN_SUBCON = '"+BA1->BA1_SUBCON+"' AND "
		C_QRY += "BTN_VERSUB = '"+BA1->BA1_VERSUB+"' AND "
		C_QRY += "BTN_CODPRO = '"+BA1->BA1_CODPLA+"' AND "
		C_QRY += "BTN_VERPRO = '"+BA1->BA1_VERSAO+"' AND "
		C_QRY += "D_E_L_E_T_ = ' ' AND BTN_TABVLD = ' ' "
		C_QRY += "ORDER BY BTN_CODFAI"
		
		PLSQUERY(C_QRY, "TRB1")      
		C_FAIXA := "000"
		
		WHILE !TRB1->( EOF() )   
		
			C_FAIXA := SOMA1(C_FAIXA)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ TRANSFERE OS VALORES DA FORMA DE COBRANCA...                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//TRY
			
			BDK->( RECLOCK("BDK", .T.) )
			FOR NCNT := 1 TO BDK->( FCOUNT() )
				CCAMPO 		:= BDK->( FIELD(NCNT) )
				
				IF CCAMPO == "BDK_CODINT"
					BDK->( FIELDPUT(NCNT, BA1->BA1_CODINT ) )
					
				ELSEIF CCAMPO == "BDK_CODEMP"
					BDK->( FIELDPUT(NCNT, BA1->BA1_CODEMP ) )
					
				ELSEIF CCAMPO == "BDK_MATRIC"
					BDK->( FIELDPUT(NCNT, BA1->BA1_MATRIC ) )

	 				
	 			
	 			ELSEIF CCAMPO == "BDK_VALOR"
					BDK->( FIELDPUT(NCNT, TRB1->BTN_VALFAI ) )
	 		
	 			ELSEIF CCAMPO == "BDK_TIPREG"
					BDK->( FIELDPUT(NCNT, BA1->BA1_TIPREG ) )

	 			ELSEIF CCAMPO == "BDK_TIPREG"
					BDK->( FIELDPUT(NCNT, BA1->BA1_TIPREG ) )

	 			ELSEIF CCAMPO == "BDK_CODFAI"
					BDK->( FIELDPUT(NCNT, C_FAIXA ) )
					
				ELSE
					CCAMPOBTN := "TRB1->"+STRTRAN(CCAMPO, "BDK","BTN")
					IF BTN->(FIELDPOS(SUBSTR(CCAMPOBTN,7))) > 0 .AND.;
						BDK->(FIELDPOS(CCAMPO)) > 0
						
						BDK->( FIELDPUT(NCNT, &CCAMPOBTN) )
						
					ENDIF
				ENDIF
			
			NEXT 
			
		  	/*	
		  	
		  	If c_FaiIni == BDK->BDK_IDAINI .and. c_FaiFin == BDK->BDK_IDAFIN		
			     
				BA1->( RECLOCK("BA1", .T.) )	
				   
					BA1->BA1_FAICOB := BDK->BDK_CODFAI  
				
				BA1->(MSUNLOCK()) 
			
			EndIf 
			
			*/
		
			BDK->( MSUNLOCK() )    
			
			     
		
	
	TRB1->( dbSkip() )
	
	
			//CATCH
			
		  //	AADD(A_ERRO, {"BDK", C_MATUSU, "ERRO RECLOK"} )
		//	tBDK := .F.
			
			//ENDCATCH   
		
		ENDDO
		
		TRB1->( dbCloseArea() )
		
	ENDIF

Return